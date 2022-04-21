# resource "aws_vpc" "myvpc" {
#   cidr_block = "10.0.0.0/16"
# }
# ###############
# resource "aws_internet_gateway" "igw" {
#   vpc_id = aws_vpc.myvpc.id

#   tags = {
#     Name = "main"
#   }
# }
# ###############
# resource "aws_subnet" "mysubnet" {
#   vpc_id     = aws_vpc.myvpc.id
#   cidr_block = "10.0.1.0/24"

#   tags = {
#     Name = "Main"
#   }
# }
# ###############
# resource "aws_route_table" "example" {
#   route_table_id                     = route_table_id.example.id
#   destination_cidr_block             = "0.0.0.0/0"
#   gateway_id                         = aws_internet_gateway.igw.id
#   depends_on                         =[aws_route_table.rt]
# }
       
#  #############

#  resource "aws_security_group" "allow_tls" {
#   name        = "allow_tls"
#   description = "Allow TLS inbound traffic"
#   vpc_id      = aws_vpc.main.id

#   ingress {
#     description      = "TLS from VPC"
#     from_port        = 443
#     to_port          = 443
#     protocol         = "tcp"
#     cidr_blocks      = [aws_vpc.main.cidr_block]
#     ipv6_cidr_blocks = [aws_vpc.main.ipv6_cidr_block]
#   }

#   egress {
#     from_port        = 0
#     to_port          = 0
#     protocol         = "-1"
#     cidr_blocks      = ["0.0.0.0/0"]
#     ipv6_cidr_blocks = ["::/0"]
#   }

#   tags = {
#     Name = "allow_tls"
#   }
# }


resource "aws_vpc" "main" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "main"
  }
}

