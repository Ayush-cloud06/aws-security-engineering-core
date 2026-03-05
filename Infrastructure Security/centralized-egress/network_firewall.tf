resource "aws_networkfirewall_firewall_policy" "egress_policy" {
  name = "egress-firewall-policy"

  firewall_policy {
    stateless_default_actions          = ["aws:forward_to_sfe"]
    stateless_fragment_default_actions = ["aws:forward_to_sfe"]
  }
}

# Firewall resource
resource "aws_networkfirewall_firewall" "egress_firewall" {
  name                = "egress-firewall"
  vpc_id              = var.vpc_id
  firewall_policy_arn = aws_networkfirewall_firewall_policy.egress_policy.arn

  subnet_mapping {
    subnet_id = var.public_subnet_ids[0]
  }
}

# Allow only HTTPS outbound
resource "aws_networkfirewall_rule_group" "allow_https" {
  name     = "allow-https-egress"
  capacity = 100
  type     = "STATEFUL"

  rule_group {
    rules_source {
      rules_string = <<EOF
pass tcp any any -> any 443 (msg:"Allow HTTPS"; sid:1;)
EOF
    }
  }
}
