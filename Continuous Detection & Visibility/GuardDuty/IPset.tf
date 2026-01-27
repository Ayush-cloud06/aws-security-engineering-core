# Currently in GuardDuty, users from member accounts cannot upload and further manage IPSets. 
# IPSets that are uploaded by the primary account are imposed on GuardDuty functionality in its member accounts.

data "aws_caller_identity" "current" {}

resource "aws_guardduty_ipset" "example" {
  activate    = true
  detector_id = aws_guardduty_detector.main.id
  format      = "TXT"
  location    = "https://s3.amazonaws.com/${aws_s3_object.MyIPSet.bucket}/${aws_s3_object.MyIPSet.key}"
  name        = "MyIpSet"
}

resource "aws_s3_bucket" "ipbucket" {
  bucket = "guardduty-ipset-${data.aws_caller_identity.current.account_id}"

  force_destroy = true # okay for labs, remove in prod

  tags = {
    Name      = "guardduty-ipset-bucket"
    Purpose   = "GuardDuty IPSet storage"
    ManagedBy = "Terraform"
    Security  = "High"
  }
}

resource "aws_s3_bucket_public_access_block" "ipbucket" {
  bucket = aws_s3_bucket.ipbucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}


resource "aws_s3_bucket_acl" "bucket_acl" {
  bucket = aws_s3_bucket.ipbucket.id
  acl    = "private"
}

resource "aws_s3_object" "MyIPSet" {
  content = "10.0.0.0/8\n"
  bucket  = aws_s3_bucket.ipbucket.id
  key     = "MyIPSet"
}

# optional encryption

resource "aws_s3_bucket_server_side_encryption_configuration" "ipbucket" {
  bucket = aws_s3_bucket.ipbucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_policy" "allow_guardduty" {
  bucket = aws_s3_bucket.ipbucket.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "AllowGuardDutyRead"
        Effect    = "Allow"
        Principal = { Service = "guardduty.amazonaws.com" }
        Action    = ["s3:GetObject", "s3:GetBucketLocation"]
        Resource  = "${aws_s3_bucket.ipbucket.arn}/*"
      }
    ]
  })
}
