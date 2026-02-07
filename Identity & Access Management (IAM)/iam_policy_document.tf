data "aws_iam_policy_document" "GRC_trust" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "AWS"
      identifiers = [aws_iam_user.auditor_user.arn]
    }
  }
}
