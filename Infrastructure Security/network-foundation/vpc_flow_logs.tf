# IAM Role for Flow Logs
resource "aws_iam_role" "flow_logs_role" {

  name = "vpc-flow-logs-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "vpc-flow-logs.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

# IAM Policy
resource "aws_iam_role_policy" "flow_logs_policy" {

  name = "vpc-flow-logs-policy"
  role = aws_iam_role.flow_logs_role.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents",
          "logs:DescribeLogGroups",
          "logs:DescribeLogStreams"
        ]
        Resource = "*"
      }
    ]
  })
}

# Log Group
resource "aws_cloudwatch_log_group" "vpc_flow_logs" {
  name              = "/security/vpc-flow-logs"
  retention_in_days = 365
}

# VPC Flow Logs Resources
resource "aws_flow_log" "vpc_flow_logs" {

  vpc_id                   = aws_vpc.secure_vpc.id
  traffic_type             = "ALL"
  log_destination_type     = "cloud-watch-logs"
  log_group_name           = aws_cloudwatch_log_group.vpc_flow_logs.arn
  iam_role_arn             = aws_iam_role.flow_logs_role.arn
  max_aggregation_interval = 60
  log_format               = "$${version} $${account-id} $${interface-id} $${srcaddr} $${dstaddr} $${srcport} $${dstport} $${protocol} $${packets} $${bytes} $${action} $${log-status}"
}
