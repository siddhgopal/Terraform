terraform {
  required_version = "~>1.1.3"
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}
provider "aws" {
  region  = "us-east-1"
  profile = "mayank"
}

resource "aws_instance" "my_ec2" {
  ami               = "ami-08e4e35cccc6189f4"
  availability_zone = "us-east-1a"
  instance_type     = "t2.micro"
  count             = 5
  tags = {
    "Name" = "My-ec2-${count.index}"
  }
}