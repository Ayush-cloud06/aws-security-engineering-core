resource "aws_iam_role_policy_attachment" "grc_auditor_attachment" {
  role       = aws_iam_role.GRC_role.name
  policy_arn = aws_iam_policy.grc_auditor_policy.arn
}
