provider "aws" {
  region     = "ap-south-1"
  access_key = "AKIAWE56CCKB2A6UY64E"
  secret_key = "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"
 }

variable "elbname" {
    type = string
 }

variable "timeout" {
    type = number
 }

variable "azname" {
    type = list
    default = ["us-west-2a", "us-west-2b", "us-west-2c"]
 }

resource "aws_elb" "bar" {
  name               = var.elbname
  availability_zones = var.azname
 }

listener {
    instance_port     = 8000
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }
   
health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:8000/"
    interval            = 30
  }

  cross_zone_load_balancing   = true
  idle_timeout                =     var.timeout 
  connection_draining         = true
  connection_draining_timeout = var.timeout 

  tags = {
    Name = "siddhgopalsoni"
   }
}


