resource "aws_iam_security_token_service_preferences" "strict" {
  global_endpoint_token_version = "v2Token"
}
