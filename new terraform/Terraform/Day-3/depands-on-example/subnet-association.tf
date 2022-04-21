#Route table subnet association
resource "aws_route_table_association" "public-subnet" {
  subnet_id      = aws_subnet.Public.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "private-subnet" {
  subnet_id      = aws_subnet.Private.id
  route_table_id = aws_route_table.private.id
}
