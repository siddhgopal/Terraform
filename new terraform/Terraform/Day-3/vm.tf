#create Ec2 Instance
resource "aws_instance" "terraform-publc-instance" {
  ami                    = data.aws_ami.amzlinux.id
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.Public.id
  key_name               = "terraform-key"
  depends_on             = [aws_vpc.terraform-vpc]
  user_data              = <<-EOF
     #!/bin/bash
    sudo yum update -y
    sudo yum install httpd -y
    echo "<h1>AWS Infra created using Terraform in us-east-1 Region</h1>" > /var/www/html/index.html
    sudo systemctl enable httpd
    sudo systemctl start httpd
    EOF
  vpc_security_group_ids = [aws_security_group.Terraform-sg.id]

  tags = {
    Name = "terraform"
  }
}

resource "aws_instance" "terraform-private-instance" {
  ami                    = "ami-08e4e35cccc6189f4"
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.Private.id
  depends_on             = [aws_vpc.terraform-vpc]
  key_name               = "terraform-key"
  vpc_security_group_ids = [aws_security_group.Terraform-private-sg.id]
  tags = {
    Name = "private"
  }
}