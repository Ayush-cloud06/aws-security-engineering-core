data "aws_security_groups" "public_groups" {

  filter {
    name   = "ip-permission.cidr"
    values = ["0.0.0.0/0"]
  }

}
