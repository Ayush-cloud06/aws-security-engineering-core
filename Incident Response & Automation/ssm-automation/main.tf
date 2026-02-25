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
