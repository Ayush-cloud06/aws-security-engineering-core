# -----------------------------------------------------------------------------
# CloudWatch Dashboard
# -----------------------------------------------------------------------------
# Dashboards provide a single-pane-of-glass view into metrics, alarms,
# and operational context.

# This dashboard is intentionally simple:
# - One real signal (EC2 CPU)
# - One documentation widget (text)
# -----------------------------------------------------------------------------

resource "aws_cloudwatch_dashboard" "main" {

  # Name as it appears in the AWS Console
  dashboard_name = "core-infra-observability"

  # dashboard_body must be valid JSON
  # jsonencode() allows us to write native HCL maps/lists safely
  dashboard_body = jsonencode({

    # Widgets are placed on a 24-column grid
    widgets = [

      # -----------------------------------------------------------------------
      # Metric Widget: EC2 CPU Utilization
      # -----------------------------------------------------------------------
      # Purpose:
      # - Monitor baseline compute health
      # - Detect runaway processes or resource starvation
      # - Correlate with scaling or security findings
      # -----------------------------------------------------------------------
      {
        type = "metric"

        # Layout positioning
        x      = 0
        y      = 0
        width  = 12 # Half-width dashboard
        height = 6

        properties = {
          metrics = [
            [
              "AWS/EC2",
              "CPUUtilization",
              "InstanceId",
              "i-012345" # Example instance ID (replace per environment)
            ]
          ]

          # 5-minute granularity keeps noise low
          period = 300

          # Average is preferred for trend visibility
          stat = "Average"

          # Region of the monitored resource
          region = "us-east-1"

          title = "EC2 CPU Utilization"
        }
      },

      # -----------------------------------------------------------------------
      # Text Widget: Operational Context / Runbook Notes
      # -----------------------------------------------------------------------
      # Text widgets are critical for:
      # - Ownership clarity
      # - Incident response guidance
      # - Audit context
      # -----------------------------------------------------------------------
      {
        type = "text"

        # Positioned below the metric widget
        x      = 0
        y      = 7
        width  = 12
        height = 4

        properties = {
          markdown = <<EOF
### Core Infrastructure Dashboard

**Purpose**
- Baseline infrastructure health monitoring
- Entry point for incident triage

**If CPU spikes**
1. Check Auto Scaling activity
2. Review recent deployments
3. Correlate with GuardDuty / Inspector findings

**Owner:** Cloud Security Team  
**Severity:** Medium
EOF
        }
      }
    ]
  })
}
