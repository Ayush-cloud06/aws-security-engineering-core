terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0"
    }
  }
}

# Baseline enablement for AWS Audit Manager in the account/region.
resource "aws_auditmanager_account_registration" "this" {
  delegated_admin_account = null
}
