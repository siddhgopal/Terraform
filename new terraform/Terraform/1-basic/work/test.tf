# terraform Block
terraform {
  required_version = "~>1.1.0"
  required_providers {
     aws = {
      source = "hashicorp/aws"
      version = "3.72.0"
    }
  }
}
# Credentails

provider "aws" {
 profile = "mayank"
 region = "us-east-1"
}

# resource Block
resource "aws_instance" "ec2-deployment" {
  ami           = "ami-08e4e35cccc6189f4"
  instance_type = "t2.micro"

}