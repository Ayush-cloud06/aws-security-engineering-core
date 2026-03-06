# This ensures instances require IMDSv2, preventing common credential-stealing attacks.
resource "aws_launch_template" "secure_metadata" {
  name_prefix = "secure-metadata"
  metadata_options {
    http_endpoint               = "enabled"
    http_tokens                 = "required"
    http_put_response_hop_limit = 2
  }
}
