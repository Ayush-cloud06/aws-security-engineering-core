resource "aws_guardduty_member" "member" {
  account_id         = "123456789874"
  detector_id        = aws_guardduty_detector.main.id
  email              = "required@example.com"
  invite             = true
  invitation_message = "Become member of guardduty organizational unit"
}
