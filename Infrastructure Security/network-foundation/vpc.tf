resource "aws_vpc" "secure_vpc" {

  cidr_block = "10.10.0.0/16"

  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {

    Name = "core-secure-vpc"

    SecurityBoundary = "Core-Infrastructure"

  }
}

resource "aws_default_vpc" "disable" {

  tags = {
    Name = "Disabled-Default-VPC"
  }

}
