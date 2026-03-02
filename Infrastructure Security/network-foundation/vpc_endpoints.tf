# Dedicated Endpoint Security Group
resource "aws_security_group" "endpoint_sg" {
  name        = "vpc-endpoints-sg"
  vpc_id      = aws_vpc.secure_vpc.id
  description = "Security group for VPC Interface Endpoints"

  ingress {
    description = "Allow HTTPS from VPC"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"

    cidr_blocks = [
      aws_vpc.secure_vpc.cidr_block
    ]
  }
  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"

    cidr_blocks = [
      "0.0.0.0/0"
    ]
  }
  tags = {
    Name = "endpoint-security-group"
  }
}

# ---- S3 Gateway Endpoints ----
resource "aws_vpc_endpoint" "s3" {
  vpc_id            = aws_vpc.secure_vpc.id
  service_name      = "com.amazonaws.ap-south-1.s3"
  vpc_endpoint_type = "Gateway"

  route_table_ids = [
    aws_route_table.app_rt.id,
    aws_route_table.db_rt.id,
    aws_route_table.security_rt.id
  ]
  tags = {
    Name = "s3-endpoint"
  }
}

# ---- STS Endpoint ----
resource "aws_vpc_endpoint" "sts" {
  vpc_id            = aws_vpc.secure_vpc.id
  service_name      = "com.amazonaws.ap-south-1.sts"
  vpc_endpoint_type = "Interface"

  subnet_ids = [
    aws_subnet.security_a.id,
    aws_subnet.security_b.id
  ]
  security_group_ids = [
    aws_security_group.endpoint_sg.id
  ]
  private_dns_enabled = true

  tags = {
    Name = "sts-endpoint"
  }
}

# ---- KMS Endpoint ----
resource "aws_vpc_endpoint" "kms" {
  vpc_id            = aws_vpc.secure_vpc.id
  service_name      = "com.amazonaws.ap-south-1.kms"
  vpc_endpoint_type = "Interface"

  subnet_ids = [
    aws_subnet.security_a.id,
    aws_subnet.security_b.id
  ]

  security_group_ids = [
    aws_security_group.endpoint_sg.id
  ]

  private_dns_enabled = true

  tags = {
    Name = "kms-endpoint"
  }

}

# ---- CloudWatch Logs Endpoints ----
resource "aws_vpc_endpoint" "logs" {
  vpc_id            = aws_vpc.secure_vpc.id
  service_name      = "com.amazonaws.ap-south-1.logs"
  vpc_endpoint_type = "Interface"

  subnet_ids = [
    aws_subnet.security_a.id,
    aws_subnet.security_b.id
  ]

  security_group_ids = [
    aws_security_group.endpoint_sg.id
  ]

  private_dns_enabled = true
  tags = {
    Name = "cloudwatch-endpoint"
  }

}
