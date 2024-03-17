resource "aws_route_table" "public" {
  vpc_id = aws_vpc.dev-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.dev-igw.id
  }

  tags = {
    Name       = "dev-vpc"
    managed_by = var.managed_by
  }
}

resource "aws_route_table" "private1" {
  vpc_id = aws_vpc.dev-vpc.id

  tags = {
    Name       = "dev-vpc"
    managed_by = var.managed_by
  }
}

resource "aws_route_table" "private2" {
  vpc_id = aws_vpc.dev-vpc.id

  tags = {
    Name       = "dev-vpc"
    managed_by = var.managed_by
  }
}
