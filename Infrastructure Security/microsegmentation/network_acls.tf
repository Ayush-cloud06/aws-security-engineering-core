# NACLs act as fail-safe guardrails if SGs are misconfigured.

resource "aws_network_acl" "app_nacl" {

  vpc_id = var.vpc_id

  subnet_ids = var.app_subnet_ids

  tags = {
    Name = "app-tier-nacl"
  }
}

# Inbound Rule : Allow ALB traffic
resource "aws_network_acl_rule" "app_ingress_https" {

  network_acl_id = aws_network_acl.app_nacl.id

  rule_number = 100
  egress      = false

  protocol    = "tcp"
  rule_action = "allow"

  cidr_block = "10.10.0.0/16"

  from_port = 443
  to_port   = 443

}

# Deny Everything Else
resource "aws_network_acl_rule" "app_deny_all" {

  network_acl_id = aws_network_acl.app_nacl.id

  rule_number = 200
  egress      = false

  protocol    = "-1"
  rule_action = "deny"

  cidr_block = "0.0.0.0/0"

  from_port = 0
  to_port   = 0

}
