# SECURITY HUB CONFIGURATION POLICIES
# Defines how Security Hub behaves across the entire organization.
# Requires CENTRAL organization configuration.

resource "aws_securityhub_configuration_policy" "baseline" {
  name        = "Baseline-Security-Posture"
  description = "Default security baseline for all organization accounts"

  configuration_policy {
    service_enabled = true

    enabled_standard_arns = [
      "arn:aws:securityhub:ap-south-1::standards/aws-foundational-security-best-practices/v/1.0.0",
      "arn:aws:securityhub:::ruleset/cis-aws-foundations-benchmark/v/1.2.0"
    ]

    # Enable all controls by default
    security_controls_configuration {
      disabled_control_identifiers = []
    }
  }

  depends_on = [
    aws_securityhub_organization_configuration.org
  ]
}
/*
# Strict policy → only selected controls allowed
resource "aws_securityhub_configuration_policy" "strict" {
  name        = "Strict-Control-Policy"
  description = "Only allow explicitly approved security controls"

  configuration_policy {
    service_enabled = true

    enabled_standard_arns = [
      "arn:aws:securityhub:ap-south-1::standards/aws-foundational-security-best-practices/v/1.0.0"
    ]

    security_controls_configuration {
      enabled_control_identifiers = [
        "IAM.7",
        "APIGateway.1"
      ]
    }
  }
}


-> Organization Configuration decides who controls Security Hub.
   Configuration Policies decide what Security Hub enforces.
*/

