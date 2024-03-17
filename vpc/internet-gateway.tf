resource "aws_internet_gateway" "dev-igw" {
  vpc_id = aws_vpc.dev-vpc.id

  tags = {
    Name       = "dev-vpc"
    managed_by = var.managed_by
  }
}
