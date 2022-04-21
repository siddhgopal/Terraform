#Internet gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.terraform-vpc.id

  tags = {
    Name = "igw"
  }
}
# Elastic IP
resource "aws_eip" "nat" {
  vpc = true
}

# NAT Gateway
resource "aws_nat_gateway" "private" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.Private.id

  tags = {
    Name = "private"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.igw]
}
