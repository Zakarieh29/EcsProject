resource "aws_vpc" "custom_vpc" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = "default"

  tags = {
    Name = "custom_vpc"
  }
}

resource "aws_internet_gateway" "igw_custom" {
  vpc_id = aws_vpc.custom_vpc.id

  tags = {
    Name = "igw_custom"
  }
}

resource "aws_subnet" "public_sn" {
  vpc_id     = aws_vpc.custom_vpc.id
  cidr_block = var.public_sn_cidr
  map_public_ip_on_launch = true

  tags = {
    Name = "public subnet"
  }
}

resource "aws_route_table" "custom_routetable" {
  vpc_id = aws_vpc.custom_vpc.id

  route {
    cidr_block = var.route_table_cidr_block
    gateway_id = aws_internet_gateway.igw_custom.id
  }

  tags = {
    Name = "custom_routetable"
  }
}

resource "aws_subnet" "private_sn" {
  vpc_id     = aws_vpc.custom_vpc.id
  cidr_block = var.private_sn_cidr
  map_public_ip_on_launch = false

  tags = {
    Name = "private subnet"
  }
}

resource "aws_route_table_association" "custom_rta" {
  subnet_id      = aws_subnet.public_sn.id
  route_table_id = aws_route_table.custom_routetable.id
}

resource "aws_route_table" "private_routetable" {
  vpc_id = aws_vpc.custom_vpc.id

  tags = {
    Name = "private_routetable"
  }
}

resource "aws_route_table_association" "private_rta" {
  subnet_id      = aws_subnet.private_sn.id
  route_table_id = aws_route_table.private_routetable.id
}
