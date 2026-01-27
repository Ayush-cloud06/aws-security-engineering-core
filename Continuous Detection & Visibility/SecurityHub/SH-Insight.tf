# Security Hub Insights define analytical views on security findings.
# You can filter insights by almost *any* property of a finding.
# Think of filters as your SOC query language.

# Examples of common filters:

# By severity:
#   severity_label = CRITICAL / HIGH / MEDIUM / LOW

# By product (who generated the finding):
#   product_name = GuardDuty / Inspector / Security Hub / Macie

# By account:
#   aws_account_id = "123456789012"

# By region:
#   resource_region = "ap-south-1"

# By compliance result:
#   compliance_status = FAILED / PASSED / WARNING

# By resource:
#   resource_id = "arn:aws:s3:::mybucket/*"
#   resource_type = "AwsS3Bucket"

# By time:
#   created_at → last X days
#   updated_at → recent activity

# By network:
#   network_source_ipv4 = "10.0.0.0/16"
#   network_destination_port = 22

# By tags:
#   resource_tags { key = "Environment", value = "Production" }

# By workflow:
#   workflow_status = NEW / NOTIFIED / SUPPRESSED / RESOLVED

# By confidence:
#   confidence >= 80

# By automation metadata:
#   user_defined_fields { key = "tier", value = "crown-jewel" }

# By malware info (GuardDuty / Inspector):
#   malware_name
#   malware_state
#   malware_type

# By threat intel:
#   threat_intel_indicator_type
#   threat_intel_indicator_value

# By process:
#   process_name
#   process_path
#   process_pid

# By service:
#   generator_id
#   company_name


resource "aws_securityhub_insight" "critical_by_resource" {

  depends_on = [
    aws_securityhub_account.hub
  ]

  name = "Critical Findings by Resource"

  # Only include CRITICAL findings
  filters {
    severity_label {
      comparison = "EQUALS"
      value      = "CRITICAL"
    }
  }

  # Group results by resource
  group_by_attribute = "ResourceId"
}

# -> Show me a list of resources, ranked by how many CRITICAL findings they have.

# Shows which AWS accounts generate most GuardDuty alerts.

resource "aws_securityhub_insight" "guardduty_by_account" {

  name = "GuardDuty Findings by Account"

  filters {
    product_name {
      comparison = "EQUALS"
      value      = "GuardDuty"
    }
  }

  group_by_attribute = "AwsAccountId"
}

/*
# ============================================================================
# Security Hub Insight: GuardDuty Findings by Account

# ============================================================================

resource "aws_securityhub_insight" "guardduty_by_account" {

  name = "GuardDuty Findings by Account"

  filters {
    product_name {
      comparison = "EQUALS"
      value      = "GuardDuty"
    }
  }

  group_by_attribute = "AwsAccountId"
}
*/
