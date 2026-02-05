/*
# To enable AWS organizations
resource "aws_organizations_organization" "main" {
  aws_service_access_principals = ["iam.amazonaws.com"]
  feature_set                   = "ALL"
}
*/

resource "aws_iam_organizations_features" "root_controls" {
  enabled_features = [
    "RootCredentialsManagement",
    "RootSessions"
  ]
}
