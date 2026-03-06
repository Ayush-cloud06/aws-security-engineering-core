resource "aws_kms_key" "platform_key" {
  description             = "Platform data encryption key"
  enable_key_rotation     = true
  deletion_window_in_days = 7

  tags = {
    Purpose = "data-protection"
  }
}
