# =============================================================================
# CloudWatch Contributor Insights
#
# Purpose:
#   Identify top contributors to metrics or log patterns.
#   This enables root-cause analysis, abuse detection, and investigation.
# Contributor Insights DO NOT trigger alerts directly.
# =============================================================================

# -----------------------------------------------------------------------------
# Custom Contributor Insight Rule
# Example use case:
#   From Lambda logs, identify which country contributes most to
#   log events matching a specific keyword.
#
# Typical security patterns:
#   - Top IPs causing AccessDenied
#   - Top users triggering auth failures
#   - Top regions / countries hitting APIs
# -----------------------------------------------------------------------------

resource "aws_cloudwatch_contributor_insight_rule" "lambda_country_contributors" {
  rule_name  = "lambda-country-contributors"
  rule_state = "ENABLED"

  # This JSON defines the "question" CloudWatch answers.
  # It counts log events containing a keyword and groups them by country.
  rule_definition = jsonencode({
    Schema = {
      Name    = "CloudWatchLogRule"
      Version = 1
    }

    AggregateOn = "Count"

    Contribution = {
      Filters = [
        {
          Match = "$.message"
          In    = ["some-keyword"]
        }
      ]
      Keys = [
        "$.country"
      ]
    }

    LogFormat = "JSON"
    LogGroupNames = [
      "/aws/lambda/api-prod"
    ]
  })
}


# -----------------------------------------------------------------------------
# AWS-Managed Contributor Insight Rule
# Example use case:
#   Enable a predefined insight for a VPC Endpoint Service
#   to understand traffic contribution by endpoint ID.
#
# Managed rules are recommended as a first step before custom rules.
# -----------------------------------------------------------------------------

/* Reference :-
resource "aws_cloudwatch_contributor_managed_insight_rule" "vpc_endpoint_traffic" {
  resource_arn  = aws_vpc_endpoint_service.test.arn
  template_name = "VpcEndpointService-BytesByEndpointId-v1"

  # Disabled by default to avoid unnecessary cost/noise.
  # Can be enabled when analysis is required.
}

*/
