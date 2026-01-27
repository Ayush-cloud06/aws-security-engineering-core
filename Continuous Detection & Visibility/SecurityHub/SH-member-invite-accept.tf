# Note: AWS accounts can only be associated with a single Security Hub master account. 
# Destroying this resource will disassociate the member account from the master account.

/*
resource "aws_securityhub_member" "member" {
  account_id = "123456789012"
  email      = "example@example.com"
  invite     = true
}

resource "aws_securityhub_account" "invitee" {
  provider = aws.invitee
}

resource "aws_securityhub_invite_accepter" "invitee" {
  provider   = aws.invitee
  depends_on = [aws_securityhub_account.invitee]
  master_id  = aws_securityhub_member.member.master_id
}



resource "aws_securityhub_member" "example" {
  depends_on = [aws_securityhub_account.example]
  account_id = "123456789012"
  email      = "example@example.com"
  invite     = true
}*/
