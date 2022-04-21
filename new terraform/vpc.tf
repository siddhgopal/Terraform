# provider "aws"
provider "aws" {
  region     = "ap-south-1"
  access_key = "AKIAWE56CCKB2A6UY64E"
  secret_key = "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"
}

# aws_vpc
resource "aws_vpc" "siddhgopalvpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "siddhgopalvpc"
  }
}

# aws_subnet" "public-subnet

resource "aws_subnet" "public-subnet" {
  vpc_id     = aws_vpc.siddhgopalvpc.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "public-subnet"
  }
}

# aws_subnet" "private-subnet

resource "aws_subnet" "private-subnet" {
  vpc_id     = aws_vpc.siddhgopalvpc.id
  cidr_block = "10.0.2.0/24"

  tags = {
    Name = "public-private"
  }
}

#aws_security_group

resource "aws_security_group" "siddhgopalsg" {
  name        = "siddhgopalsg"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.siddhgopalvpc.id

  ingress {
    description      = "TLS from VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
     }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "siddhgopalsg"
  }
}

#aws_internet_gateway
resource "aws_internet_gateway" "siddhgopal-igw" {
  vpc_id = aws_vpc.siddhgopalvpc.id

  tags = {
    Name = "siddhgopal-igw"
  }
}

# aws_route_table

resource "aws_route_table" "public-rt" {
  vpc_id = aws_vpc.siddhgopalvpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.siddhgopal-igw.id
  }
 tags = {
    Name = "public-rt"
  }
}

#subnet_associate

resource "aws_main_route_table_association" "public-asso" {
  vpc_id         = aws_vpc.public-subnet.id
  route_table_id = aws_route_table.public-rt.id
}

# aws_key_pair

resource "aws_key_pair" "siddhgopal-key" {
  key_name   = "siddhgopal-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQClJLW/n0XtVhnuBkzVoTZ03s+4bhtFubuViYaDpoFGLaK/RKd108ofYenVT5xQL1WQcqCfyRVWhItZN1Vk0seNH0jeZC0Kih5WqIv3iBCgTwmM9Uugz33s0F7GSw4p+epYchdBq1Jo62HdWre0lhaFE1jluGc4xukFMGL/RceSi4xkvZ4xXwKdshsEdJo3SvDOfHjn2Y4onjQ3jVLjChcZcGF/GhiQVk5YPf868KnzUbDHpe/86apCZCB3Q30t1NtOFG3yN7Xu7aHbKEMNyGaiqgRvSVu1HSL3J0Sx8fR/hK2UShTCVvxqRTTgB6bPTgxpICcJr2EYBk89dVOMPIud root@ip-172-31-13-244.ap-south-1.compute.internal"
}

# aws_instance

resource "aws_instance" "siddhgopal-instance" {
  ami           = "ami-0fcd1778a0defc97d"
  instance_type = "t2.micro"
  subnet_id     =  "aws_subnet.public-subnet.id"
  vpc_security_group_ids = [aws_security_group.siddhgopalsg.id]
  key_name = "siddhgopal-key"
 
  tags = {
    Name = "siddhgopal-instance"
  }
}

# aws_db_instance
resource "aws_instance" "siddhgopal-db-instance" {
  ami           = "ami-0fcd1778a0defc97d"
  instance_type = "t2.micro"
  subnet_id     =  "aws_subnet.private-subnet.id"
  vpc_security_group_ids = [aws_security_group.siddhgopalsg.id]
  key_name = "siddhgopal-key"
 
  tags = {
    Name = "siddhgopal-db-instance"
  }
}

# "aws_eip"

resource "aws_eip" "siddhgopal-ip" {
  instance = aws_instance.siddhgopal-instance.id
  vpc      = true
}

resource "aws_eip" "siddhgopal-nat-ip" {
  instance = aws_instance.siddhgopal-bd-instance.id
  vpc      = true
}

# "aws_nat_gateway"
 
resource "aws_nat_gateway" "siddhgopal-nat-gateway" {
  allocation_id = aws_siddhgopal-nat-gateway.id
  subnet_id     = aws_subnet.public-subnet.id
}

resource "aws_route_table" "private-rt" {
  vpc_id = aws_vpc.siddhgopalvpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.siddhgopal-nat-gateway.id
  }
 tags = {
    Name = "private-rt"
  }
}

resource "aws_main_route_table_association" "private-asso" {
  vpc_id         = aws_vpc.private-subnet.id
  route_table_id = aws_route_table.public-rt.id
}
