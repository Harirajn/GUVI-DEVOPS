provider "aws" {
  region = "us-west-2"
  access_key = "********"
  secret_key = "xxxxxxxxx"
}

data "aws_vpc" "default" {
  default = true
}

data "aws_subnet" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }

  filter {
    name   = "default-for-az"
    values = ["true"]
  }

  filter {
    name = "availability-zone"
    values = ["us-west-2a"] 
  }
}

resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow SSH inbound traffic"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    description = "SSH from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "task" {
  ami           = "ami-08116b9957a259459"
  instance_type = "t2.micro"
  subnet_id     = data.aws_subnet.default.id
  vpc_security_group_ids = [aws_security_group.allow_ssh.id]

  tags = {
    Name = "task15"
  }
}
