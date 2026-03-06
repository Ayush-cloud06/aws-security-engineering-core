resource "aws_kms_key_policy" "platform_policy" {
  key_id = aws_kms_key.platform_key.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          AWS = "*"
        }
        Action   = "kms:Encrypt"
        Resource = "*"
      }
    ]
  })
}
