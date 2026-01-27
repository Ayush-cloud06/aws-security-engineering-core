# Configuration Policy = law
# Policy Association   = where the law applies

# Targets can be:
# An account ID → "123456789012"
# An OU ID → "ou-xxxx-xxxxxxxx"
# The org root → "r-xxxx"

# Policy created → Policy attached to target → Security Hub enforces configuration

# ----- Apply Policy to the entire organization (root) -----
resource "aws_securityhub_configuration_policy_association" "org_root" {
  policy_id = aws_securityhub_configuration_policy.baseline.id
  target_id = data.aws_organizations_organization.org.roots[0].id
}

/*
# Apply policy to a specific OU
  resource "aws_securityhub_configuration_policy_association" "prod_ou" {
  policy_id = aws_securityhub_configuration_policy.baseline.id
  target_id = "ou-xxxx-yyyyyyyy"
 }

# Apply policy to a specific account
  resource "aws_securityhub_configuration_policy_association" "security_account" {
   policy_id = aws_securityhub_configuration_policy.baseline.id
   target_id = "123456789012"
 }
*/





