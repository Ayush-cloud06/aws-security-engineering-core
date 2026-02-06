# Admin / Security Engineering Group
resource "aws_iam_group" "security_admins" {
  name = "security-admins"
  path = "/system/"
}

# Compliance / Audit Group
resource "aws_iam_group" "compliance_auditors" {
  name = "compliance-auditors"
  path = "/audit/"
}
