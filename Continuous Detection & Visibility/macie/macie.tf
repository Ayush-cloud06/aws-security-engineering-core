# Enable Macie for the AWS account

resource "aws_macie2_account" "macie" {
  finding_publishing_frequency = "FIFTEEN_MINUTES"
  status                       = "ENABLED"
}
