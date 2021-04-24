resource "aws_vpc" "vpc" {
  cidr_block = var.cidr
  tags = var.tags
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags = var.tags
}

resource "aws_subnet" "public_subnet" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = var.subnet_ids[0]
  tags = {
    Name = "public-subnet"
  }
}

resource "aws_subnet" "private_subnet1" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = var.subnet_ids[1]
  tags = {
    Name = "private-subnet1"
  }
}

resource "aws_subnet" "private_subnet2" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = var.subnet_ids[2]
  tags = {
    Name = "private-subnet2"
  }
}

resource "aws_eip" "nat_eip" {
  vpc = true  
}

resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public_subnet.id
}

resource "aws_route_table" "public-rt" {
  vpc_id = aws_vpc.vpc.id
  route {
      cidr_block = "0.0.0.0/0"
      gateway_id = aws_internet_gateway.igw.id
  }
}

resource "aws_route_table" "private-rt" {
  vpc_id = aws_vpc.vpc.id
  route {
      cidr_block = "0.0.0.0/0"
      gateway_id = aws_nat_gateway.nat_gw.id
  }
}

resource "aws_route_table_association" "pub-assoc" {
  subnet_id = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public-rt.id
}

resource "aws_route_table_association" "priv1-assoc" {
  subnet_id = aws_subnet.private_subnet1.id
  route_table_id = aws_route_table.private-rt.id
}

resource "aws_route_table_association" "priv2-assoc" {
  subnet_id = aws_subnet.private_subnet2.id
  route_table_id = aws_route_table.private-rt.id
}