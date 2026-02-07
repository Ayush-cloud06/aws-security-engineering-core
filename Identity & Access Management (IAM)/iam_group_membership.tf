resource "aws_iam_group_membership" "audit_team" {
  name  = "audit-group-membership"
  users = [aws_iam_user.auditor_user.name]
  group = aws_iam_group.compliance_auditors.name
}

resource "aws_iam_group_membership" "admin" {
  name  = "admin-membership"
  users = [aws_iam_user.admin_user.name]
  group = aws_iam_group.security_admins.name
}
