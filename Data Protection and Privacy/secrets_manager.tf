resource "aws_secretsmanager_secret" "db_credentials" {
  name       = "database-credentials"
  kms_key_id = aws_kms_key.platform_key.arn
}
