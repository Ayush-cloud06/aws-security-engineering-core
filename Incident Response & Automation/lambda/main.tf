# Lambda Function
data "archive_file" "dispatcher_zip" {
  type        = "zip"
  source_dir  = "${path.module}/src"
  output_path = "${path.module}/package/dispatcher.zip"
}

resource "aws_lambda_function" "security_dispatcher" {
  filename         = data.archive_file.dispatcher_zip.output_path
  function_name    = "security-core-dispatcher"
  role             = aws_iam_role.lambda_exec.arn
  handler          = "remediation_dispatcher.lambda_handler"
  runtime          = "python3.11"
  timeout          = 60
  source_code_hash = data.archive_file.dispatcher_zip.output_base64sha256

  environment {
    variables = {
      LOG_LEVEL     = "INFO"
      SNS_TOPIC_ARN = "arn:aws:sns:ap-south-1:123456789012:security-critical-alerts"
    }
  }
}

# IAM Role
resource "aws_iam_role" "lambda_exec" {
  name = "security-dispatcher-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action    = "sts:AssumeRole"
      Effect    = "Allow"
      Principal = { Service = "lambda.amazonaws.com" }
    }]
  })
}


resource "aws_iam_policy" "remediation_permissions" {
  name        = "security-remediation-policy"
  description = "Allows the dispatcher to fix security issues"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid      = "FixIAM"
        Effect   = "Allow"
        Action   = ["iam:ListAccessKeys", "iam:DeleteAccessKey"]
        Resource = "*"
      },
      {
        Sid      = "FixSecurityGroups"
        Effect   = "Allow"
        Action   = ["ec2:DescribeSecurityGroups", "ec2:RevokeSecurityGroupIngress"]
        Resource = "*"
      },
      {
        Sid      = "FixS3"
        Effect   = "Allow"
        Action   = ["s3:PutBucketPublicAccessBlock"]
        Resource = "*"
      },
      {
        Sid      = "SendAlerts"
        Effect   = "Allow"
        Action   = ["sns:Publish"]
        Resource = "*" # Or lock down to your specific SNS ARN
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "attach_remediation" {
  role       = aws_iam_role.lambda_exec.name
  policy_arn = aws_iam_policy.remediation_permissions.arn
}

resource "aws_iam_role_policy_attachment" "basic_exec" {
  role       = aws_iam_role.lambda_exec.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}


# This allows EventBridge to actually touch the Lambda.
resource "aws_lambda_permission" "allow_eventbridge" {
  statement_id  = "AllowExecutionFromEventBridge"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.security_dispatcher.function_name
  principal     = "events.amazonaws.com"
  # Optional: Lock it to your specific bus ARN for extra security
  # source_arn  = var.security_bus_arn 
}

