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

resource "aws_security_group" "office_ssh" {
  vpc_id      = "vpc-0951fb531d20fe80a"
  name        = "office_ssh Security Group"
  description = "office_ssh Security Group"

  tags { Name = "office_ssh Security Group" }
}
