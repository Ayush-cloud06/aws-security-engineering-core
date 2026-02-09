# Instance Profile to allow Services to assume IAM roles
# Demonstration purpose only, all instance profiles attached to GRC role temporarily
# ---- Instance profile for EC2 service role ---
resource "aws_iam_instance_profile" "ec2_profile" {
  name = "ec2-instance-profile"
  path = "/audit/"

  role = aws_iam_role.GRC_role.name

  tags = {
    RoleType = "Service"
    Project  = "SoulCanvas"
  }
}
