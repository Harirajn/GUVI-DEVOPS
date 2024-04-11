provider "aws" {
  region = "us-west-2"
}

# Create a new VPC
resource "aws_vpc" "my_vpc" {
  cidr_block       = "10.0.0.0/16"
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = {
    Name = "my_vpc"
  }
}

# Create 3 subnets in different AZs for high availability
resource "aws_subnet" "my_subnet" {
  count                   = 3
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = cidrsubnet(aws_vpc.my_vpc.cidr_block, 8, count.index)
  availability_zone       = element(
                              flatten([
                                for az in data.aws_availability_zones.available.names : 
                                  list(az)
                              ]), 
                              count.index)
  map_public_ip_on_launch = true
  tags = {
    Name = "my_subnet-${count.index}"
  }
}

data "aws_availability_zones" "available" {
  state = "available"
}

# Security Group to allow SSH and web access
resource "aws_security_group" "my_sg" {
  name        = "sg_SSH"
  description = "Allow SSH and HTTP"
  vpc_id      = aws_vpc.my_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "my_sg"
  }
}

# Create 2 EC2 instances in 2 different subnets
resource "aws_instance" "my_instance" {
  count                  = 2
  ami                    = "ami-08116b9957a259459" 
  instance_type          = "t2.micro"
  subnet_id              = element(aws_subnet.my_subnet.*.id, count.index)
  security_groups        = [aws_security_group.my_sg.name]

  tags = {
    Name = "Instance-${count.index}"
  }
}
