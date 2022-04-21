terraform {
  required_version = "value"
  required_providers {
    aws = {
      source = "value"
      version = "value"
     }
  }
}

provider "aws" {
  profile = "mayank"
  region = "us-east-1"
  alias = "n-virginia"
}

provider "aws" {
  profile = "mayank"
  region = "ap-south-1"
  alias = "mumbai"
}

resource "" "name" {
  
}