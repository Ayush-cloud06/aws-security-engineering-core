# Provides a resource to manage an AWS Macie Custom Data Identifier.
resource "aws_macie2_custom_data_identifier" "macie_data_identifier_ex" {
  name                   = "NAME OF CUSTOM DATA IDENTIFIER"
  regex                  = "[0-9]{3}-[0-9]{2}-[0-9]{4}"
  description            = "DESCRIPTION"
  maximum_match_distance = 10
  keywords               = ["keyword"]
  ignore_words           = ["ignore"]

  depends_on = [aws_macie2_account.macie]
}
