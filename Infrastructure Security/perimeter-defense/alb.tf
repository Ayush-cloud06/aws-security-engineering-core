resource "aws_lb" "secure_alb" {

  name               = "secure-edge-alb"
  load_balancer_type = "application"

  security_groups = [var.alb_security_group_id]

  subnets = var.public_subnet_ids

  enable_deletion_protection = true

  access_logs {
    bucket  = "alb-access-logs-secure"
    enabled = true
  }

  tags = {
    Tier = "Edge"
  }

}
