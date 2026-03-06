resource "aws_s3_bucket" "central_logs" {
  bucket        = "platform-central-logs-secure"
  force_destroy = false

  tags = {
    Purpose = "security-logging"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "logs_encryption" {

  bucket = aws_s3_bucket.central_logs.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }

}
