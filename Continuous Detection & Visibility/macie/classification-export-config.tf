# Provides a resource to manage an Amazon Macie Classification Export Configuration.

resource "aws_macie2_classification_export_configuration" "macieexport" {
  depends_on = [
    aws_macie2_account.macie,
  ]
  s3_destination {
    bucket_name = aws_s3_bucket.macie_export_bucket.bucket
    key_prefix  = "exampleprefix/"
    kms_key_arn = aws_kms_key.macie_kms.arn
  }
}

resource "aws_kms_key" "macie_kms" {
  description             = "KMS key for Macie export encryption"
  deletion_window_in_days = 7
  enable_key_rotation     = true
}

resource "aws_s3_bucket" "macie_export_bucket" {
  bucket = "macie-export"
}

resource "aws_s3_bucket_server_side_encryption_configuration" "macie_enc" {
  bucket = aws_s3_bucket.macie_export_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_key.macie_kms.arn
      sse_algorithm     = "aws:kms"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "macie_block" {
  bucket = aws_s3_bucket.macie_export_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}



