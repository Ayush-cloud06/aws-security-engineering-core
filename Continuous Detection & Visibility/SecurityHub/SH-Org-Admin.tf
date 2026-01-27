
resource "aws_organizations_organization" "org" {
  aws_service_access_principals = ["securityhub.amazonaws.com"]
  feature_set                   = "ALL"
}

data "aws_caller_identity" "current" {}
data "aws_organizations_organization" "org" {}

resource "aws_securityhub_account" "hub" {}

resource "aws_securityhub_organization_admin_account" "org" {
  depends_on = [aws_organizations_organization.org, aws_securityhub_account.hub]

  admin_account_id = data.aws_caller_identity.current.account_id
  /*
  You cannot make the Organization Management Account the Delegated Administrator for Security Hub (or GuardDuty). 
  AWS forbids this to separate concerns. You must delegate to a member account (like a dedicated Security Tooling account).
  */
}

# Auto enable security hub in organization member accounts
resource "aws_securityhub_organization_configuration" "org" {
  auto_enable = true
}
