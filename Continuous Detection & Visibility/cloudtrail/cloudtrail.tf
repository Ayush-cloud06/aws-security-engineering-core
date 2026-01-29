# For a multi-region trail, this resource must be in the home region of the trail.
# For an organization trail, this resource must be in the master account of the organization.
#For capturing events from services like IAM, include_global_service_events must be enabled.

data "aws_partition" "current" {}
data "aws_region" "current" {}
data "aws_caller_identity" "current" {}

# S3 BUCKET – FORENSIC LOG VAULT
# This bucket stores all CloudTrail logs.

resource "aws_s3_bucket" "cloudtrail_logs" {
  bucket        = "ayush-cloudtrail-log-vault"
  force_destroy = true # for labs; remove in production
}

# Block ALL public access (non-negotiable for logs)
resource "aws_s3_bucket_public_access_block" "cloudtrail_logs" {
  bucket                  = aws_s3_bucket.cloudtrail_logs.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# Enable versioning so deleted/overwritten logs are still recoverable
resource "aws_s3_bucket_versioning" "cloudtrail_logs" {
  bucket = aws_s3_bucket.cloudtrail_logs.id
  versioning_configuration {
    status = "Enabled"
  }
}

# KMS – ENCRYPTION KEY FOR CLOUDTRAIL

resource "aws_kms_key" "cloudtrail_key" {
  description         = "KMS key for encrypting CloudTrail logs"
  enable_key_rotation = true
}

# S3 BUCKET POLICY – ALLOW ONLY CLOUDTRAIL

data "aws_iam_policy_document" "cloudtrail_bucket_policy" {

  # CloudTrail must be able to check the bucket ACL
  statement {
    sid    = "CloudTrailAclCheck"
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["cloudtrail.amazonaws.com"]
    }

    actions   = ["s3:GetBucketAcl"]
    resources = [aws_s3_bucket.cloudtrail_logs.arn]

    condition {
      test     = "StringEquals"
      variable = "aws:SourceArn"
      values = [
        "arn:${data.aws_partition.current.partition}:cloudtrail:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:trail/security-core-trail"
      ]
    }
  }

  # CloudTrail must be able to write logs into S3
  statement {
    sid    = "CloudTrailWrite"
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["cloudtrail.amazonaws.com"]
    }

    actions = ["s3:PutObject"]

    resources = [
      "${aws_s3_bucket.cloudtrail_logs.arn}/cloudtrail/AWSLogs/${data.aws_caller_identity.current.account_id}/*"
    ]

    # Enforces ownership control on written logs
    condition {
      test     = "StringEquals"
      variable = "s3:x-amz-acl"
      values   = ["bucket-owner-full-control"]
    }

    # Prevents spoofed CloudTrail writes
    condition {
      test     = "StringEquals"
      variable = "aws:SourceArn"
      values = [
        "arn:${data.aws_partition.current.partition}:cloudtrail:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:trail/security-core-trail"
      ]
    }
  }
}

resource "aws_s3_bucket_policy" "cloudtrail_logs" {
  bucket = aws_s3_bucket.cloudtrail_logs.id
  policy = data.aws_iam_policy_document.cloudtrail_bucket_policy.json
}

# CLOUDTRAIL – THE MEMORY OF YOUR SECURITY SYSTEM

resource "aws_cloudtrail" "security_core_trail" {
  name = "security-core-trail"

  # Where logs go
  s3_bucket_name = aws_s3_bucket.cloudtrail_logs.id
  s3_key_prefix  = "cloudtrail"

  # Enables detection of log tampering
  enable_log_file_validation = true

  # Required for IAM, STS, CloudFront visibility
  include_global_service_events = true

  # Required for real security coverage
  is_multi_region_trail = true

  # Encrypt logs using KMS
  kms_key_id = aws_kms_key.cloudtrail_key.arn

  # Ensure policy is in place before trail creation
  depends_on = [aws_s3_bucket_policy.cloudtrail_logs]
}



#   KMS Key Policy 
resource "aws_kms_key_policy" "cloudtrail_key_policy" {
  key_id = aws_kms_key.cloudtrail_key.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "Enable IAM User Permissions"
        Effect = "Allow"
        Principal = {
          AWS = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
        }
        Action   = "kms:*"
        Resource = "*"
      },
      {
        Sid    = "Allow CloudTrail to encrypt logs"
        Effect = "Allow"
        Principal = {
          Service = "cloudtrail.amazonaws.com"
        }
        Action   = "kms:GenerateDataKey*"
        Resource = "*"
        Condition = {
          StringLike = {
            "kms:EncryptionContext:aws:cloudtrail:arn" = "arn:aws:cloudtrail:*:${data.aws_caller_identity.current.account_id}:trail/*"
          }
        }
      }
    ]
  })
}
