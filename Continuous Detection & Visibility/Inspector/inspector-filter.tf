# Filters allow us to control Inspector findings:
# - Suppress known acceptable risks
# - Reduce alert fatigue
# - Enforce SOC signal quality

resource "aws_inspector2_filter" "suppress_low_risk_test_account" {
  name   = "Suppress-Low-Risk-Test-Account"
  action = "SUPPRESS"

  filter_criteria {

    # Apply only to a specific test / sandbox account
    aws_account_id {
      comparison = "EQUALS"
      value      = "111222333444"
    }

    # (Optional) You would usually combine this with:
    # severity = LOW or MEDIUM
  }
}


/*
# suppressed low severity 
resource "aws_inspector2_filter" "suppress_low" {
  name   = "Suppress-Low-Severity"
  action = "SUPPRESS"

  filter_criteria {
    severity {
      comparison = "EQUALS"
      value      = "LOW"
    }
  }
}
*/


/*
# Suppress accepted CVEs
resource "aws_inspector2_filter" "accepted_risk" {
  name   = "Accepted-Risk-CVE"
  action = "SUPPRESS"

  filter_criteria {
    vulnerability_id {
      comparison = "EQUALS"
      value      = "CVE-2021-12345"
    }
  }
}
*/
