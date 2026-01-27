/*

# Security Hub Automation Rules

Automation Rules are the *policy engine* of Security Hub.

They run BEFORE any EventBridge / Lambda / Slack automation and are used to:
- Normalize findings
- Re-classify severity
- Add governance metadata
- Add analyst notes
- Control workflow status
- Suppress / prioritize noise

Think of them as:
Firewall rules, but for security findings.

Execution model:

    Findings enter Security Hub
            ↓
    Automation Rule #1 (rule_order = 1)
            ↓
    Automation Rule #2 (rule_order = 2)
            ↓
    ...
            ↓
    Findings leave Security Hub → EventBridge → Automation

If a rule is marked `is_terminal = true`, processing stops there !

# This module is written from the perspective of the *Security Admin Account*.
===============================================================================
*/

# Automation Rule: Elevate severity for critical production resources

# This is a classic SOC pattern:
# If a finding touches a crown-jewel resource → it becomes CRITICAL automatically.
# No human judgement needed.

resource "aws_securityhub_automation_rule" "critical_prod_resources" {

  depends_on = [aws_securityhub_account.hub]


  # Human readable explanation
  description = "Elevate severity to CRITICAL when findings relate to protected production resources"

  # Name visible in console
  rule_name = "Critical-Prod-Resource-Escalation"

  # Order matters: lower number = higher priority
  # This rule runs first in the pipeline
  rule_order = 1

  # Optional but recommended 
  rule_status = "ENABLED"

  # false = allow other rules to still execute after this one
  is_terminal = false

  # Criteria: What findings does this rule apply to?

  # This is the IF part of the logic.
  #
  # IF:
  #   resource_id == "arn:aws:s3:::prod-sensitive-bucket/*"
  #
  # Then:
  #   apply actions below
  #
  # Criteria blocks are filters on ASFF (AWS Security Finding Format) fields.

  criteria {

    # Match findings that relate to a specific S3 bucket
    resource_id {
      comparison = "PREFIX"
      value      = "arn:aws:s3:::prod-sensitive-bucket/*"
    }
  }

  # -----------------------------------------------------------------------
  # Actions: What happens when criteria matches?
  # -----------------------------------------------------------------------
  # This is the THEN part of the logic.

  actions {
    # This rule modifies the finding itself
    type = "FINDING_FIELDS_UPDATE"

    finding_fields_update {



      # 1. Upgrade severity automatically
      severity {
        label   = "CRITICAL" # Human readable severity
        product = "0"        # Native service severity override (optional)
      }

      # 2. Add an audit note to the finding
      note {
        text       = "This resource is classified as Critical Immediate investigation required."
        updated_by = "securityhub-automation"
      }

      # 3. Classify the finding under compliance/security domain
      types = [
        "Software and Configuration Checks/Industry and Regulatory Standards"
      ]

      # 4. Add metadata fields for downstream automation or dashboards
      user_defined_fields = {
        environment = "production"
        tier        = "crown-jewel"
        owner       = "cloud-security-team"
      }
    }
  }
}


// # Rule: Auto-tag GuardDuty findings with environment metadata

resource "aws_securityhub_automation_rule" "guardduty_tagging" {
  description = "Attach environment metadata to GuardDuty findings"
  rule_name   = "GuardDuty-Environment-Tagging"
  rule_order  = 2
  depends_on  = [aws_securityhub_account.hub]
  rule_status = "ENABLED"
  is_terminal = false



  criteria {
    product_name {
      comparison = "EQUALS"
      value      = "GuardDuty"
    }
  }

  actions {
    type = "FINDING_FIELDS_UPDATE"

    finding_fields_update {
      user_defined_fields = {
        source      = "guardduty"
        environment = "unknown"
      }
    }
  }
}



# =============================================================================
# Example Pattern Library (Commented)

# These are NOT executed, they are design references for future rules.
# They show how different automation policies would look in a real SOC.


/*
# ---------------------------------------------------------------------------
# Rule: Suppress low-value noisy findings
# ---------------------------------------------------------------------------
resource "aws_securityhub_automation_rule" "suppress_noise" {
  description = "Suppress known low-risk findings to reduce alert fatigue"
  rule_name   = "Suppress-Low-Risk-Findings"
  rule_order  = 100
  is_terminal = true   # Stop processing if matched

  criteria {
    severity_label {
      comparison = "EQUALS"
      value      = "LOW"
    }
  }

  actions {
    type = "FINDING_FIELDS_UPDATE"

    finding_fields_update {
      workflow {
        status = "SUPPRESSED"
      }

      note {
        text       = "Suppressed automatically due to low business impact"
        updated_by = "securityhub-automation"
      }
    }
  }
}
*/

/*
# ---------------------------------------------------------------------------
# Rule: Mark compliance failures as HIGH severity
# ---------------------------------------------------------------------------
resource "aws_securityhub_automation_rule" "compliance_escalation" {
  description = "Increase severity for failed compliance controls"
  rule_name   = "Compliance-Failure-Escalation"
  rule_order  = 5

  criteria {
    compliance_status {
      comparison = "EQUALS"
      value      = "FAILED"
    }
  }

  actions {
    type = "FINDING_FIELDS_UPDATE"

    finding_fields_update {
      severity {
        label = "HIGH"
      }

      note {
        text       = "Compliance control failure detected. Review against security baseline."
        updated_by = "securityhub-automation"
      }
    }
  }
}
*/

# Automation Rules are:
# - Deterministic
# - Stateless
# - Policy-driven
