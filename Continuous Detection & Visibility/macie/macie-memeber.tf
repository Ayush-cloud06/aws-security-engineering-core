
resource "aws_macie2_member" "maciemember" {
  account_id                            = "123456789987"
  email                                 = "EMAIL@gmail.com"
  invite                                = true
  invitation_message                    = "Join the macie OU"
  invitation_disable_email_notification = true
  depends_on                            = [aws_macie2_account.macie]
}


# Invite acceptor for member accounts

/*
resource "aws_macie2_invitation_accepter" "accept_invite" {
  administrator_account_id = "111111111111"
}
*/
