#
resource "aws_instance" "pub-ins" {
ami = "ami-08e4e35cccc6189f4"
instance_type = "t2.micro"
subnet_id = aws_subnet.public-sn.id
key_name = "terraform"
depends_on = [aws_vpc.t-vpc]
vpc_security_group_ids = [aws_security_group.public-allow.id]
tags = {
Name = "public-vm"
}
}

Placement Group 

add Placement group 