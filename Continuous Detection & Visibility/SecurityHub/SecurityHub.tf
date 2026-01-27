# Enable Security hub, Deleting this is equivalent of disabling security hub
# This module assumes AWS Config is already enabled in the account.
# Security Hub compliance standards depend on AWS Config to evaluate resource state and control status.
# This account is a centrally managed security control plane with deterministic compliance behavior
/*resource "aws_securityhub_account" "hub" {
  enable_default_standards  = true
  control_finding_generator = "SECURITY_CONTROL"
  auto_enable_controls      = true
}
# same config in SH-Org-Admin.tf
*/

# Action Target

resource "aws_securityhub_action_target" "hub" {
  depends_on  = [aws_securityhub_account.hub]
  name        = "Send slack alert"
  identifier  = "SendToSlack"
  description = "This is custom action that sends selected findings"
}
