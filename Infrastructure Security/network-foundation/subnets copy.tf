/*
10.10.1.0/24   Public-A
10.10.2.0/24   Public-B

10.10.11.0/24  App-A
10.10.12.0/24  App-B

10.10.21.0/24  DB-A
10.10.22.0/24  DB-B

10.10.31.0/24  Security-A
10.10.32.0/24  Security-B
*/

data "aws_availability_zones" "available" {
  state = "available"
}

# ---- Public Subents (ALB only) ----
resource "aws_subnet" "public_a" {
  vpc_id                  = aws_vpc.secure_vpc.id
  cidr_block              = "10.10.1.0/24"
  availability_zone       = data.aws_availability_zones.available.names[0]
  map_public_ip_on_launch = false

  tags = {
    Name     = "public-subnet-a"
    Tier     = "Public"
    Exposure = "Internet-Facing"

  }
}


resource "aws_subnet" "public_b" {
  vpc_id                  = aws_vpc.secure_vpc.id
  cidr_block              = "10.10.2.0/24"
  availability_zone       = data.aws_availability_zones.available.names[1]
  map_public_ip_on_launch = false

  tags = {
    Name     = "public-subnet-b"
    Tier     = "Public"
    Exposure = "Internet-Facing"

  }
}

# ----- Application Subnets -----
resource "aws_subnet" "app_a" {
  vpc_id                  = aws_vpc.secure_vpc.id
  cidr_block              = "10.10.11.0/24"
  availability_zone       = data.aws_availability_zones.available.names[0]
  map_public_ip_on_launch = false

  tags = {
    Name     = "app-subnet-a"
    Tier     = "Application"
    Exposure = "Internet-Facing"
  }
}

resource "aws_subnet" "app_b" {
  vpc_id                  = aws_vpc.secure_vpc.id
  cidr_block              = "10.10.12.0/24"
  availability_zone       = data.aws_availability_zones.available.names[1]
  map_public_ip_on_launch = false

  tags = {
    Name     = "app-subnet-b"
    Tier     = "Application"
    Exposure = "Private"
  }
}

# ----- Database Subnets -----
resource "aws_subnet" "db_a" {
  vpc_id                  = aws_vpc.secure_vpc.id
  cidr_block              = "10.10.21.0/24"
  availability_zone       = data.aws_availability_zones.available.names[0]
  map_public_ip_on_launch = false

  tags = {
    Name     = "db-subnet-a"
    Tier     = "Database"
    Exposure = "Isolated"
  }
}


resource "aws_subnet" "db_b" {
  vpc_id                  = aws_vpc.secure_vpc.id
  cidr_block              = "10.10.22.0/24"
  availability_zone       = data.aws_availability_zones.available.names[1]
  map_public_ip_on_launch = false

  tags = {
    Name     = "db-subnet-b"
    Tier     = "Database"
    Exposure = "Isolated"
  }
}

# ----- Reserved Security Subnets -----
resource "aws_subnet" "security_a" {
  vpc_id                  = aws_vpc.secure_vpc.id
  cidr_block              = "10.10.31.0/24"
  availability_zone       = data.aws_availability_zones.available.names[0]
  map_public_ip_on_launch = false

  tags = {
    Name     = "security-subnet-a"
    Tier     = "Security"
    Exposure = "Private"
  }
}


resource "aws_subnet" "security_b" {
  vpc_id                  = aws_vpc.secure_vpc.id
  cidr_block              = "10.10.32.0/24"
  availability_zone       = data.aws_availability_zones.available.names[1]
  map_public_ip_on_launch = false

  tags = {
    Name     = "security-subnet-b"
    Tier     = "Security"
    Exposure = "Private"
  }
}
