# Aggregates Security Hub findings from all AWS regions into this account.
# This is required for centralized security visibility and organization-level governance.

resource "aws_securityhub_finding_aggregator" "central" {
  linking_mode = "ALL_REGIONS"

  depends_on = [aws_securityhub_account.hub]
}
