resource "aws_securityhub_product_subscription" "guardduty" {
  product_arn = "arn:aws:securityhub:ap-south-1::product/aws/guardduty"

  depends_on = [
    aws_securityhub_account.hub
  ]
}


/* 
# Inspector → Security Hub
resource "aws_securityhub_product_subscription" "inspector" {
  product_arn = "arn:aws:securityhub:${var.region}::product/aws/inspector"

  depends_on = [
    aws_securityhub_account.hub
  ]
}

# Macie → Security Hub
resource "aws_securityhub_product_subscription" "macie" {
  product_arn = "arn:aws:securityhub:${var.region}::product/aws/macie"

  depends_on = [
    aws_securityhub_account.hub
  ]
}

# IAM Access Analyzer → Security Hub
resource "aws_securityhub_product_subscription" "iam_access_analyzer" {
  product_arn = "arn:aws:securityhub:${var.region}::product/aws/iam-access-analyzer"

  depends_on = [
    aws_securityhub_account.hub
  ]
}
........ etc 
 */ 
