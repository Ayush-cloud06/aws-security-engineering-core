# -----------------------------------------------------------------------------
# SNS Topic for Critical Alerts
# Purpose:
#   Central notification channel for CloudWatch composite alarms.
#   This can later fan-out to email, Slack, PagerDuty, EventBridge, etc.
# -----------------------------------------------------------------------------

resource "aws_sns_topic" "critical_alerts" {
  name = "cloudwatch-critical-alerts"

  tags = {
    Purpose = "Critical CloudWatch Alarms"
    Scope   = "SecurityAndAvailability"
  }
}
