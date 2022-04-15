terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

  required_version = ">= 0.14.9"
}

provider "aws" {
  profile = "default"
  region  = "ap-northeast-2"
}

resource "aws_security_group" "office ssh" {
  vpc_id = "vpc-0951fb531d20fe80a"
  name = "office ssh"
  description = "Terraform home ssh SG"
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["222.121.135.254/32"]
  }
}

resource "aws_instance" "app_server" {
  ami           = "ami-0f949cb787308f8a7"
  instance_type = "t2.micro"
#  vpc_security_group_ids = [aws_security_group.basic_security.id]

  tags = {
    Name = "hello world 1"
  }
}