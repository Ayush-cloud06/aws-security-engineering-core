# This resource must be created in the Organization's Administrator Account.

resource "aws_inspector2_enabler" "org_enabler" {
  account_ids    = ["123456789123"]
  resource_types = ["EC2", "ECR", "LAMBDA"]
}

/*
For the Calling Account

data "aws_caller_identity" "current" {}

resource "aws_inspector2_enabler" "self" {
  account_ids    = [data.aws_caller_identity.current.account_id]
  resource_types = ["ECR", "EC2"]
}*/
