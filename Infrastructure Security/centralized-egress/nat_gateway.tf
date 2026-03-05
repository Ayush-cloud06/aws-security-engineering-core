resource "aws_eip" "nat_eip" { # -> NAT must have a public IP, otherwise it cannot reach the internet. 
  #    The “no public IP assignment” idea applies to instances, not NAT gateways.
  domain = "vpc"
}

resource "aws_nat_gateway" "egress_nat" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = var.public_subnet_ids[0]

  tags = {
    Name = "centralized-egress-nat"
  }
}

# Route private traffic to NAT
resource "aws_route" "app_egress" {

  route_table_id         = var.app_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.egress_nat.id
}
