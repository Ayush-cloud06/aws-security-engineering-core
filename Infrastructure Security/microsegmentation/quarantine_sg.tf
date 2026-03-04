resource "aws_security_group" "quarantine_sg" {
  name        = "quarantine-sg"
  description = "Isolation security group for incident response containment"

  vpc_id                 = aws_vpc.secure_vpc.id
  revoke_rules_on_delete = true

  tags = {
    Name = "quarantine-security-group"
    Tier = "IncidentResponse"
  }
}
