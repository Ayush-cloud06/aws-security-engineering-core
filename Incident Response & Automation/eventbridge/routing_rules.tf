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

# Send the Root Key Event to your lambda
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

# 2: Detect Public S3 Buckets (via AWS Config)
resource "aws_cloudwatch_event_rule" "s3_public_rule" {
  name           = "detect-public-s3-bucket"
  description    = "Triggers when AWS Config flags an S3 bucket as public"
  event_bus_name = aws_cloudwatch_event_bus.security_bus.name

  event_pattern = jsonencode({
    source      = ["aws.config"]
    detail-type = ["Config Rules Compliance Change"]
    detail = {
      configRuleName = ["s3-bucket-public-read"]
      newEvaluationResult = {
        complianceType = ["NON_COMPLIANT"]
      }
    }
  })
}

resource "aws_cloudwatch_event_target" "send_s3_to_lambda" {
  rule           = aws_cloudwatch_event_rule.s3_public_rule.name
  event_bus_name = aws_cloudwatch_event_bus.security_bus.name
  arn            = "arn:aws:lambda:ap-south-1:123456789012:function:security-core-dispatcher"

  dead_letter_config {
    arn = aws_sqs_queue.event_dlq.arn
  }
}


# 3: Detect Open SSH 0.0.0.0/0 (via AWS Config)
resource "aws_cloudwatch_event_rule" "sg_ssh_rule" {
  name           = "detect-open-ssh"
  description    = "Triggers when AWS Config flags a Security Group with open port 22"
  event_bus_name = aws_cloudwatch_event_bus.security_bus.name

  event_pattern = jsonencode({
    source      = ["aws.config"]
    detail-type = ["Config Rules Compliance Change"]
    detail = {
      configRuleName = ["restricted-ssh"]
      newEvaluationResult = {
        complianceType = ["NON_COMPLIANT"]
      }
    }
  })
}

resource "aws_cloudwatch_event_target" "send_sg_to_lambda" {
  rule           = aws_cloudwatch_event_rule.sg_ssh_rule.name
  event_bus_name = aws_cloudwatch_event_bus.security_bus.name
  arn            = "arn:aws:lambda:ap-south-1:123456789012:function:security-core-dispatcher"

  dead_letter_config {
    arn = aws_sqs_queue.event_dlq.arn
  }
}
