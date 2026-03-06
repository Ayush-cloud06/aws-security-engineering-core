resource "aws_secretsmanager_secret_rotation" "db_rotation" {
  secret_id = aws_secretsmanager_secret.db_credentials.id

  rotation_rules {
    automatically_after_days = 30
  }
}
