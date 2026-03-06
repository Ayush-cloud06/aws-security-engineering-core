resource "aws_backup_vault" "platform_vault" {
  name = "platform-backup-vault"
}

# ------ Backup-policies ------
resource "aws_backup_plan" "daily_backup" {
  name = "daily-backup-plan"
  rule {
    rule_name         = "daily"
    target_vault_name = aws_backup_vault.platform_vault.name
    schedule          = "cron(0 5 * * ? *)"

    lifecycle {
      delete_after = 30
    }
  }
}

# ------ DR strategy ------
resource "aws_backup_vault" "dr_vault" {
  name = "disaster-recovery-vault"
}
