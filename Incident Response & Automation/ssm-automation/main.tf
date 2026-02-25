# ----------- EC2 quarantine ------------
# 1. Upload the Runbook to AWS SSM
resource "aws_ssm_document" "quarantine_ec2" {
  name            = "IR-Quarantine-EC2"
  document_type   = "Automation"
  document_format = "YAML"
  content         = file("${path.module}/runbooks/quarantine_ec2.yaml")

  tags = {
    Purpose = "Incident Response"
    Action  = "Forensic Isolation"
  }
}

# 2. Give SSM role
resource "aws_iam_role" "ssm_automation_role" {
  name = "ssm-incident-response-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action    = "sts:AssumeRole"
      Effect    = "Allow"
      Principal = { Service = "ssm.amazonaws.com" }
    }]
  })
}

resource "aws_iam_policy" "ssm_ec2_quarantine" {
  name        = "ssm-quarantine-policy"
  description = "Allows SSM to change EC2 Security Groups"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect   = "Allow"
      Action   = ["ec2:ModifyInstanceAttribute"]
      Resource = "*" # restrict
    }]
  })
}

resource "aws_iam_role_policy_attachment" "ssm_attach" {
  role       = aws_iam_role.ssm_automation_role.name
  policy_arn = aws_iam_policy.ssm_ec2_quarantine.arn
}

# ---------- advance containment ---------
resource "aws_ssm_document" "advanced_containment" {
  name            = "IR-Advanced-EC2-Containment"
  document_type   = "Automation"
  document_format = "YAML"
  content         = file("${path.module}/runbooks/advanced_containment.yaml")

  tags = {
    Purpose = "Incident Response"
    Action  = "Forensic Snapshot and Isolation"
  }
}

resource "aws_iam_policy" "ssm_advanced_quarantine" {
  name        = "ssm-advanced-quarantine-policy"
  description = "Allows SSM to fully contain EC2s and alert SOC"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "IsolateNetworkAndTags"
        Effect = "Allow"
        Action = [
          "ec2:ModifyInstanceAttribute",
          "ec2:CreateTags"
        ]
        Resource = "*"
      },
      {
        Sid    = "ForensicSnapshots"
        Effect = "Allow"
        Action = [
          "ec2:DescribeInstances",
          "ec2:CreateSnapshot"
        ]
        Resource = "*"
      },
      {
        Sid    = "NukeIAMProfile"
        Effect = "Allow"
        Action = [
          "ec2:DescribeIamInstanceProfileAssociations",
          "ec2:DisassociateIamInstanceProfile"
        ]
        Resource = "*"
      },
      {
        Sid      = "AlertSOC"
        Effect   = "Allow"
        Action   = ["sns:Publish"]
        Resource = "*" # Or lock down to your specific SNS ARN for extra GRC points
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "ssm_advanced_attach" {
  role       = aws_iam_role.ssm_automation_role.name
  policy_arn = aws_iam_policy.ssm_advanced_quarantine.arn
}
