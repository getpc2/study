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

resource "aws_vpc" "jhh_test" {
  cidr_block           = "50.50.0.0/16"
  instance_tenancy     = "default"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "jhhtest-vpc"
  }
}

resource "aws_security_group" "office_ssh_sg" {
  vpc_id      = "${aws_vpc.jhhtest-vpc.id}"
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
  security_group_id = "${aws_security_group.office_ssh Security Group.id}"

  lifecycle { create_before_destroy = true }
}

resource "aws_instance" "app_server" {
  ami           = "ami-0f949cb787308f8a7"
  instance_type = "t2.micro"
  vpc_security_group_ids = ["${aws_security_group.office_ssh Security Group.id}"]

  tags = {
    Name = "hello world 1"
  }
}