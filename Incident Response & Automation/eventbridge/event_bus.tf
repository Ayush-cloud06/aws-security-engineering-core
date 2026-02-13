# Vault - KMS Key
resource "aws_kms_key" "eventbridge" {
  description             = "KMS key for EventBridge security bus encryption"
  deletion_window_in_days = 10
  enable_key_rotation     = true

  tags = {
    Domain = "IncidentResponse"
    Owner  = "SecurityCore"
  }
}

# Dead Letter Queue
resource "aws_sqs_queue" "event_dlq" {
  name                      = "security-eventbridge-dlq"
  message_retention_seconds = 1209600 # 14 days (Max allowed)
}

# The Event Bus
# This is the dedicated lane for Security traffic.
# We want a clean signal: Only Security Hub & GuardDuty allowed here.
resource "aws_cloudwatch_event_bus" "security_bus" {
  name = "security-bus"

  # Encrypt everything on this bus
  kms_key_identifier = aws_kms_key.eventbridge.arn

  tags = {
    Domain      = "IncidentResponse"
    Environment = "Security"
  }
}

# Logging
# This section forces the Bus to "cc" every single event into CloudWatch Logs

# The Log Group (Storage)
resource "aws_cloudwatch_log_group" "event_bus_logs" {
  name              = "/aws/events/security-bus-trace"
  retention_in_days = 90 # Keep it lean
}

# The Rule (The Filter)
resource "aws_cloudwatch_event_rule" "log_all" {
  name           = "log-all-events"
  description    = "Capture all events for debugging/audit"
  event_bus_name = aws_cloudwatch_event_bus.security_bus.name

  # The "Select *" of EventBridge
  # This pattern matches EVERYTHING.
  event_pattern = jsonencode({
    source = [{ prefix = "" }]
  })
}

# The Target ( The Connection)
resource "aws_cloudwatch_event_target" "to_logs" {
  rule           = aws_cloudwatch_event_rule.log_all.name
  event_bus_name = aws_cloudwatch_event_bus.security_bus.name
  arn            = aws_cloudwatch_log_group.event_bus_logs.arn

  # Connect the DLQ here too. If logging fails, tell SQS.
  dead_letter_config {
    arn = aws_sqs_queue.event_dlq.arn
  }
}
