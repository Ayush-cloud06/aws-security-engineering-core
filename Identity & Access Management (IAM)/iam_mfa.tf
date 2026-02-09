/*
This creates the device, but does not automatically enable MFA on the user.

Full MFA enablement usually requires:
- QR scan
- OTP sync
- Console/API interaction
*/


resource "aws_iam_virtual_mfa_device" "admin_mfa" {
  virtual_mfa_device_name = "admin-mfa-device"
  path                    = "/system/"
}

resource "aws_iam_virtual_mfa_device" "auditor_mfa" {
  virtual_mfa_device_name = "auditor-mfa-device"
  path                    = "/audit/"
}
