resource "aws_kms_key" "platform_encryption" {

  description             = "Platform default encryption key"
  deletion_window_in_days = 7
  enable_key_rotation     = true

  tags = {
    Name = "platform-encryption-key"
  }
}
