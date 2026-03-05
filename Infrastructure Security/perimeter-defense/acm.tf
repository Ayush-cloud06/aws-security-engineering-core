resource "aws_acm_certificate" "edge_cert" {

  domain_name       = "example.com"
  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name = "edge-alb-cert"
  }

}
