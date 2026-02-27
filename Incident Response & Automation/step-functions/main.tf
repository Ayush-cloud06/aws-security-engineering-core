variable "quarantine_sg_id" {
  description = "The ID of the deny-all Security Group"
  type        = string
}

variable "soc_approval_sns_arn" {
  description = "SNS Topic ARN for SOC alerts and approvals"
  type        = string
}

resource "aws_iam_role" "sfn_malware_containment_role" {
  name = "sfn-malware-containment-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "states.amazonaws.com"
      }
    }]
  })
}

# --- IAM Policy for Execution ---
resource "aws_iam_policy" "sfn_malware_containment_policy" {
  name        = "sfn-malware-containment-policy"
  description = "Allows Step Functions to snapshot, modify SG, terminate EC2, and send SNS"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "EC2ForensicsAndContainment"
        Effect = "Allow"
        Action = [
          "ec2:CreateSnapshots",
          "ec2:ModifyInstanceAttribute",
          "ec2:TerminateInstances",
          "ec2:DescribeInstances"
        ]
        Resource = "*" # In a strict prod environment, constrain this via tags
      },
      {
        Sid      = "SnsHumanApproval"
        Effect   = "Allow"
        Action   = "sns:Publish"
        Resource = var.soc_approval_sns_arn
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "sfn_attach" {
  role       = aws_iam_role.sfn_malware_containment_role.name
  policy_arn = aws_iam_policy.sfn_malware_containment_policy.arn
}

# --- The State Machine ---
resource "aws_sfn_state_machine" "malware_containment" {
  name     = "GuardDuty-Malware-Containment-Playbook"
  role_arn = aws_iam_role.sfn_malware_containment_role.arn


  definition = templatefile("${path.module}/playbooks/malware_containment.asl.json", {
    quarantine_sg_id = "sg-0123456789abcdef0"
    sns_topic_arn    = "arn:aws:sns:ap-south-1:123456789012:soc-critical-alerts"
  })

  logging_configuration {
    level                  = "ERROR"
    include_execution_data = true
    # Note: You'd typically map a CloudWatch log group ARN here for audit trails
  }

  tags = {
    Environment = "Security-Core"
    UseCase     = "Automated-Incident-Response"
  }
}
