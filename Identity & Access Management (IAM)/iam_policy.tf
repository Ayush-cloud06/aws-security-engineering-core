# A custom policy for GRC visibility
resource "aws_iam_policy" "grc_auditor_policy" {
  name        = "GRC-Auditor-Visibility"
  path        = "/audit/"
  description = "Provides read-only access to security services for GRC audits"

  # Using jsonencode as the docs suggested—it's cleaner!
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "guardduty:Get*",
          "guardduty:List*",
          "securityhub:Get*",
          "securityhub:List*",
          "macie2:Get*",
          "macie2:List*"
        ]
        Effect   = "Allow"
        Resource = "*"
      }
    ]
  })
}

