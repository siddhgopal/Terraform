# route table
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.terraform-vpc.id
  tags = {
    Name = "public"
  }
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.terraform-vpc.id
  tags = {
    Name = "private"
  }
}