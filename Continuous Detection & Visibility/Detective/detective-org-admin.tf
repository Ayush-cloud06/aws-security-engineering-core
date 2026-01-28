# Manages a Detective Organization Admin Account. 

resource "aws_organizations_organization" "orgdetective" {
  aws_service_access_principals = ["detective.amazonaws.com"]
  feature_set                   = "ALL"
}

resource "aws_detective_organization_admin_account" "orgdetectiveadmin" {
  depends_on = [aws_organizations_organization.orgdetective]
  account_id = "123456789123"
}

# Inviting member


resource "aws_detective_member" "detectivemember" {
  account_id                 = "AWS ACCOUNT ID"
  email_address              = "EMAIL"
  graph_arn                  = aws_detective_graph.orgDetective.graph_arn
  message                    = "Message of the invitation"
  disable_email_notification = true
}
