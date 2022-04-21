terraform {
  required_version = "~>1.1.0"
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "2.92.0"
    }
     aws = {
      source = "hashicorp/aws"
      version = "3.72.0"
    }
  }
}

