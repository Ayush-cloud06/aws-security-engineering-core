# PROVIDER – SECURITY / LOGGING ACCOUNT
# This provider points to the account that will
# become the CloudTrail delegated admin.

provider "aws" {
  alias  = "cloudtrail_admin"
  region = "ap-south-1"

  # credentials/profile omitted on purpose
}

# GET ACCOUNT ID OF DELEGATED ADMIN
data "aws_caller_identity" "cloudtrail_admin" {
  provider = aws.cloudtrail_admin
}

# CLOUDTRAIL DELEGATED ADMIN CONFIG
# This must be created from the AWS Organization
# management account provider.

resource "aws_cloudtrail_organization_delegated_admin_account" "cloudtrail_admin" {
  account_id = data.aws_caller_identity.cloudtrail_admin.account_id
}
