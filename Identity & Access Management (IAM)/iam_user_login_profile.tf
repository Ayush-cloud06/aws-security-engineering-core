# To enable console login for IAM users

# Admin user console access
resource "aws_iam_user_login_profile" "admin_console" {
  user = aws_iam_user.admin_user.name

  # Temporary password – user must change on first login
  password_reset_required = true
}

# Auditor console access
resource "aws_iam_user_login_profile" "auditor_console" {
  user                    = aws_iam_user.auditor_user.name
  password_reset_required = true
}
