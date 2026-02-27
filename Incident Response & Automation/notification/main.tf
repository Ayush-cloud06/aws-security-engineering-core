variable "slack_workspace_id" {
  type        = string
  description = "The ID of the Slack workspace authorized with AWS Chatbot"
}

variable "slack_channel_id" {
  type        = string
  description = "The ID of the Slack channel (e.g., C0123456789) to send alerts to"
}

# --- Central SOC Alert Topic ---
resource "aws_sns_topic" "soc_alerts" {
  name = "soc-critical-alerts"
}

# --- Topic Policy ---
resource "aws_sns_topic_policy" "soc_alerts_policy" {
  arn = aws_sns_topic.soc_alerts.arn

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "AllowSecurityServicesToPublish"
        Effect = "Allow"
        Principal = {
          Service = [
            "states.amazonaws.com",    # Step Functions
            "events.amazonaws.com",    # EventBridge
            "cloudwatch.amazonaws.com" # CloudWatch Alarms
          ]
        }
        Action   = "sns:Publish"
        Resource = aws_sns_topic.soc_alerts.arn
      }
    ]
  })
}

# --- Expose the ARN for the root module ---
output "sns_topic_arn" {
  value       = aws_sns_topic.soc_alerts.arn
  description = "ARN of the SOC alerts SNS topic"
}
