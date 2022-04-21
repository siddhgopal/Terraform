terraform {
    required_version = "=1.1.1"
  required_providers {
    mayank = {
      source = "hashicorp/aws"
      version = "3.72"
     }
  }
}

provider "mayank" {
  profile = "mayank" 
  region = "ap-south-1"
}

