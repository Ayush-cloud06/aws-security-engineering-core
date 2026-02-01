# Provides a resource to manage Amazon Macie Org Admin account

resource "aws_macie2_organization_admin_account" "macieorg" {
  admin_account_id = "123456789123"
  depends_on       = [aws_macie2_account.macie]
}
