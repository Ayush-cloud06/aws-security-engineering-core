
resource "aws_organizations_organization" "org" {
  aws_service_access_principals = ["securityhub.amazonaws.com"]
  feature_set                   = "ALL"
}

resource "aws_securityhub_account" "org" {}

resource "aws_securityhub_organization_admin_account" "org" {
  depends_on = [aws_organizations_organization.org, aws_securityhub_account.hub]

  admin_account_id = data.aws_caller_identity.current.account_id
}

# Auto enable security hub in organization member accounts
resource "aws_securityhub_organization_configuration" "org" {
  auto_enable = true
}
