# 1. Define the Shells tp avoid circular dependency
resource "aws_security_group" "alb_sg" {
  name        = "alb-security-group"
  vpc_id      = var.vpc_id
  description = "Edge load balancer security group"
}

resource "aws_security_group" "app_sg" {
  name        = "application-security-group"
  vpc_id      = var.vpc_id
  description = "Application tier security group"
}

resource "aws_security_group" "db_sg" {
  name        = "database-security-group"
  vpc_id      = var.vpc_id
  description = "Database tier security group"
}

# 2. Define the Rules

# ALB Rules
resource "aws_security_group_rule" "alb_ingress_https" {
  type              = "ingress"
  security_group_id = aws_security_group.alb_sg.id
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "alb_egress_to_app" {
  type                     = "egress"
  security_group_id        = aws_security_group.alb_sg.id
  from_port                = 443 # Keeping it specific is better GRC practice than 0
  to_port                  = 443
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.app_sg.id
}

# APP Rules
resource "aws_security_group_rule" "app_ingress_from_alb" {
  type                     = "ingress"
  security_group_id        = aws_security_group.app_sg.id
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.alb_sg.id
}

resource "aws_security_group_rule" "app_egress_to_db" {
  type                     = "egress"
  security_group_id        = aws_security_group.app_sg.id
  from_port                = 5432
  to_port                  = 5432
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.db_sg.id
}

# DB Rules
resource "aws_security_group_rule" "db_ingress_from_app" {
  type                     = "ingress"
  security_group_id        = aws_security_group.db_sg.id
  from_port                = 5432
  to_port                  = 5432
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.app_sg.id
}
