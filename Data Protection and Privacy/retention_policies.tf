resource "aws_s3_bucket_lifecycle_configuration" "retention" {

  bucket = "platform-data-bucket"
  rule {
    id     = "expire-objects"
    status = "Enabled"

    expiration {
      days = 365
    }

  }

}
