# Terraform Block
terraform {
  required_version = "~>1.1.3"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.72.0"
    }
  }
  }
  

# Provider Block 
provider "aws" {
  region  = "us-east-1"
  profile = "mayank"
}


# Vpc Setup

resource "aws_vpc" "terraform-vpc" {
  cidr_block       = "10.10.0.0/16"
  instance_tenancy = "default"
  tags = {
    "name" = "terraform-vpc"
  }
}










