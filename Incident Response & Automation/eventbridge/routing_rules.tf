# 1. Detect Root Access Key Creation
resource "aws_cloudwatch_event_rule" "root_key_rule" {
  name           = "detect-root-access-key"
  description    = "Triggers when a Root user creates an API key"
  event_bus_name = aws_cloudwatch_event_bus.security_bus.name

  event_pattern = jsonencode({
    source      = ["aws.iam"]
    detail-type = ["AWS API Call via CloudTrail"]
    detail = {
      eventsource = ["iam.amazonaws.com"]
      eventName   = ["CreateAccessKey"]
      userIdentity = {
        type = ["Root"]
      }
    }
  })
}

# 2. Send the Root Key Event to your lambda
resource "aws_cloudwatch_event_target" "send_to_lambda" {
  rule           = aws_cloudwatch_event_rule.root_key_rule.name
  event_bus_name = aws_cloudwatch_event_bus.security_bus.name

  # This needs the ARN of your Lambda function! 
  # If you are using Terraform modules, it might look like module.lambda.dispatcher_arn
  # Or you can hardcode it temporarily for testing: "arn:aws:lambda:ap-south-1:123456789012:function:security-core-dispatcher"
  arn = "arn:aws:lambda:ap-south-1:123456789012:function:security-core-dispatcher"

  # Attach the Dead Letter Queue jsut in case the Lambda crashes
  dead_letter_config {
    arn = aws_sqs_queue.event_dlq.arn
  }

}
