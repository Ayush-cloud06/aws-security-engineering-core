resource "aws_lb" "secure_alb" {

  name                       = "secure-edge-alb"
  load_balancer_type         = "application"
  security_groups            = [var.alb_security_group_id]
  subnets                    = var.public_subnet_ids
  enable_deletion_protection = true

  access_logs {
    bucket  = "alb-access-logs-secure"
    enabled = true
  }
  tags = {
    Tier = "Edge"
  }
}

resource "aws_lb_listener" "https_listener" {

  load_balancer_arn = aws_lb.secure_alb.arn
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-TLS13-1-2-2021-06"
  certificate_arn   = aws_acm_certificate.edge_cert.arn

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "Secure endpoint"
      status_code  = "200"
    }
  }
}

resource "aws_lb_listener" "http_redirect" {

  load_balancer_arn = aws_lb.secure_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}
