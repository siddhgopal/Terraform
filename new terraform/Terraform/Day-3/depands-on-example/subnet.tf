#Subnet Setup
resource "aws_subnet" "Public" {
  vpc_id                  = aws_vpc.terraform-vpc.id
  cidr_block              = "10.10.1.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "us-east-1a"
  tags = {
    Name = "public"
  }
}

resource "aws_subnet" "Private" {
  vpc_id            = aws_vpc.terraform-vpc.id
  cidr_block        = "10.10.2.0/24"
  availability_zone = "us-east-1b"

  tags = {
    Name = "Private"
  }
}