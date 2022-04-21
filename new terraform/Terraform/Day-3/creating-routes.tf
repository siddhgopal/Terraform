#Creating routes in Route-table
resource "aws_route" "public-internet-route" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  depends_on             = [aws_route_table.public]
  gateway_id             = aws_internet_gateway.igw.id
}

resource "aws_route" "private-internet-route" {
  route_table_id         = aws_route_table.private.id
  destination_cidr_block = "0.0.0.0/0"
  depends_on             = [aws_route_table.private]
  nat_gateway_id         = aws_nat_gateway.private.id
}