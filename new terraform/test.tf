provider "aws" {
  region     = "ap-south-1"
  access_key = "AKIAWE56CCKB2A6UY64E"
  secret_key = "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"
}

resource "aws_instance" "webapp" {
  ami           = "ami-0fcd1778a0defc97d"
  instance_type = "t2.micro"
   count         = 3 

  tags = {
    Name = "siddhgopal.$(count.index)"
  }
}
