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

resource "aws_instance" "app_server" {
  ami           = "ami-0f949cb787308f8a7"
  instance_type = "t2.micro"

  tags = {
    Name = "hello world 1"
  }
}

resource "aws_security_group" "office_ssh_sg" {
  vpc_id      = "vpc-0951fb531d20fe80a"
  name        = "office_ssh Security Group"
  description = "office_ssh Security Group"

  tags = { Name = "office_ssh Security Group" }
}

resource "aws_security_group_rule" "office_ssh_rule" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "TCP"
  cidr_blocks       = ["222.121.135.254/32"]
  security_group_id = "sg-0f842885e329a050b"

  lifecycle { create_before_destroy = true }
}
