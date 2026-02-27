# --- IAM Role for AWS Chatbot ---
resource "aws_iam_role" "chatbot_role" {
  name = "soc-chatbot-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "chatbot.amazonaws.com"
      }
    }]
  })
}

# --- Permission to click "Approve" or "Deny" in Slack ---
resource "aws_iam_policy" "chatbot_step_functions" {
  name        = "chatbot-step-functions-approval"
  description = "Allows Chatbot to send task success/failure for HITL approvals"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Sid    = "StepFunctionApproval"
      Effect = "Allow"
      Action = [
        "states:SendTaskSuccess",
        "states:SendTaskFailure"
      ]
      Resource = "*"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "chatbot_sfn_attach" {
  role       = aws_iam_role.chatbot_role.name
  policy_arn = aws_iam_policy.chatbot_step_functions.arn
}

# --- AWS Chatbot Slack Channel Configuration ---
resource "aws_chatbot_slack_channel_configuration" "soc_channel" {
  configuration_name = "soc-slack-alerts"

  iam_role_arn     = aws_iam_role.chatbot_role.arn
  slack_team_id    = "T01234567"
  slack_channel_id = "C01234567"

  sns_topic_arns = [aws_sns_topic.soc_alerts.arn]

  logging_level = "ERROR"

  # The hard cap on Chatbot's power inside Slack
  guardrail_policy_arns = [
    "arn:aws:iam::aws:policy/ReadOnlyAccess"
  ]
}
