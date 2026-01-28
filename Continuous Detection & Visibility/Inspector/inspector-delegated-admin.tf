# Terraform resource for managing an Amazon Inspector Delegated Admin Account.
data "aws_caller_identity" "admin" {}
resource "aws_inspector2_delegated_admin_account" "Inspector" {
  account_id = data.aws_caller_identity.admin.account_id
}
