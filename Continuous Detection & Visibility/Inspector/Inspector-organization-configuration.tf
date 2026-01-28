# only works from the Inspector Delegated Admin Account.

/*
This resource defines how Inspector behaves across the entire organization.
It controls:
- Which services are auto-enabled for scanning
- How new member accounts are onboarded
- Organization-wide vulnerability coverage
*/

resource "aws_inspector2_organization_configuration" "org_config" {
  auto_enable {

    # Virtual machines
    ec2 = true

    # Container images
    ecr = true

    # Lambda package scanning
    lambda = true

    # Lambda source code scanning
    lambda_code = true
  }
}
