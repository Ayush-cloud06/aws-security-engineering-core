resource "aws_iam_role" "GRC_role" {
  name               = "Grc-role"
  path               = "/audit/"
  assume_role_policy = data.aws_iam_policy_document.GRC_trust.json

  max_session_duration = 3600

  tags = {
    RoleType = "Service"
    Project  = "SOC"
  }
}
