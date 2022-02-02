#1. CREATE VPC
resource "aws_vpc" "vpc-customer" {
  cidr_block       = "10.20.0.0/16"
 #cidr_block       = "10.20.22.0/24"

  tags = {
    Name = "vpc-customer" #change customer with project name
  }
}

#2. CREATE SUBNET
resource "aws_subnet" "public-customer-1" {
  vpc_id     = aws_vpc.vpc-customer.id
  cidr_block = "10.20.0.0/24"

  tags = {
    Name = "public-customer-1"
  }
}

resource "aws_subnet" "private-customer-1" {
  vpc_id     = aws_vpc.vpc-customer.id
  cidr_block = "10.20.1.0/24"

  tags = {
    Name = "private-customer-1"
  }
}

resource "aws_subnet" "private-customer-2" {
  vpc_id     = aws_vpc.vpc-customer.id
  cidr_block = "10.20.2.0/24"

  tags = {
    Name = "private-customer-1"
  }
}

#3. CREATE INTERNET GATEWAY
resource "aws_internet_gateway" "igw-customer" {
  vpc_id = aws_vpc.vpc-customer.id

  tags = {
    Name = "igw-customer"
  }
}

#4. CREATE NAT GATEWAY
resource "aws_eip" "eip-customer" {
  vpc      = true
}

resource "aws_nat_gateway" "nat-customer" {
  allocation_id = aws_eip.eip-customer.id
  subnet_id     = aws_subnet.public-customer-1.id

  tags = {
    Name = "nat-customer"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.igw-customer]
}

#5. CREATE ROUTE TABLE AND ASSOC

resource "aws_route_table" "rt-public-customer" {
  vpc_id = aws_vpc.vpc-customer.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw-customer.id
  }

  tags = {
    Name = "rt-public-customer"
  }
}

resource "aws_route_table_association" "subnet-assoc-public-a" {
  subnet_id      = aws_subnet.public-customer-1.id
  route_table_id = aws_route_table.rt-public-customer.id
}

resource "aws_route_table" "rt-private-customer" {
  vpc_id = aws_vpc.vpc-customer.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat-customer.id
  }

  tags = {
    Name = "rt-private-customer"
  }
}

resource "aws_route_table_association" "subnet-assoc-priv-a" {
  subnet_id      = aws_subnet.private-customer-1.id
  route_table_id = aws_route_table.rt-private-customer.id
}

resource "aws_route_table_association" "subnet-assoc-priv-b" {
  subnet_id      = aws_subnet.private-customer-2.id
  route_table_id = aws_route_table.rt-private-customer.id
}