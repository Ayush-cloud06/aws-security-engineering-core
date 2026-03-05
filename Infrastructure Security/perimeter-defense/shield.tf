resource "aws_shield_protection" "alb_protection" {

  name         = "alb-ddos-protection"
  resource_arn = aws_lb.secure_alb.arn

}
