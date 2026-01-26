/*
Member account side of GuardDuty setup.
This file is only used in the MEMBER AWS account to accept
an invitation sent by the PRIMARY (security) account.
Normally kept commented in the main repo and used as a reference/template.


resource "aws_guardduty_detector" "member" {
  provider = aws.dev
  enable   = true
}

resource "aws_guardduty_invite_accepter" "accept" {
  provider   = aws.dev
  depends_on = [aws_guardduty_member.member]

  # Detector running in the member account
  detector_id = aws_guardduty_detector.member.id

  # Account ID of the primary (security) account that sent the invite
  master_account_id = aws_guardduty_detector.primary.account_id
}

Flow:
Primary account → sends invite
Member account  → creates detector → accepts invite
After this, all member findings flow into the primary account.
*/
