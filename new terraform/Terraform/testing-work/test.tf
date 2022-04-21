# terraform Block
terraform {
  required_version = "~>1.1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.72.0"
    }
  }
}
# Credentails

provider "aws" {
  profile = "mayank"
  region  = "us-east-1"
  alias   = "n_virginia"
}

provider "aws" {
  profile = "mayank"
  region  = "ap-south-1"
  alias   = "mumbai"
}


# resource Block
resource "aws_instance" "ec2-deployment" {
  provider          = aws.n_virginia
  ami               = "ami-08e4e35cccc6189f4"
  instance_type     = "t2.micro"
  availability_zone = "us-east-1b"
  tags = {
    "Name" = "Terraform-created"
  }

}

resource "aws_instance" "ec2-deployment-1" {
  provider          = aws.mumbai
  ami               = "ami-0af25d0df86db00c1"
  instance_type     = "t2.micro"
  availability_zone = "ap-south-1a"
  tags = {
    "Name" = "Terraform-created"
  }

}