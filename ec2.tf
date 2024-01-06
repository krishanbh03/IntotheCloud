terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }
  required_version = ">= 1.2.0"
}

provider "aws" {
  region  = "us-east-2"
}

# Instance for t3.large ansible
resource "aws_instance" "ec2-ansible" {
  ami           = "ami-0283a57753b18025b"
  instance_type = "t2.micro"
  tags = {
    Name = "ansible"
  }
  # Giving reference of security group
  security_groups = [aws_security_group.sg-ansible.name]
}

# Security Group for ansible
resource "aws_security_group" "sg-ansible" {
  name = "security-group-ansible"
  description = "Allow HTTP and SSH traffic for Ansible server"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
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

# Instance for t2.micro app-server
resource "aws_instance" "app-server" {
  ami           = "ami-0283a57753b18025b"
  instance_type = "t2.micro"
  tags = {
    Name = "app-server"
  }
  # Giving reference of security group
  security_groups = [aws_security_group.sg-app-server.name]
}

# Security Group for app-server
resource "aws_security_group" "sg-app-server" {
  name = "security-group-app-server"
  description = "Allow HTTP and SSH traffic for app-server"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
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

