variable "project_name" {
    default = "sample"
}
variable "instance_type" {
    default = "t3a.medium"
}
variable "dns_zone" {}
variable "dns_zone_id" {}
# use default region from provider.tf

data "aws_ami" "ubuntu_lts" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "stal_instance" {
  ami                       = data.aws_ami.ubuntu_lts.id
  instance_type             = var.instance_type
  subnet_id                 = aws_subnet.stal_subnet.id
  vpc_security_group_ids    = [aws_security_group.stal_web_sg.id]
  
  associate_public_ip_address = true

  tags                      = {
      Name = "stal_${var.project_name}"
  }
}

# we need to have vpc and subnet for launching intances in vpc
resource "aws_vpc" "stal_vpc" {
  cidr_block = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support = true
}

resource "aws_subnet" "stal_subnet" {
  vpc_id = aws_vpc.stal_vpc.id
  cidr_block = "10.0.1.0/24"
  # availability_zone = "us-west-1a"
}

resource "aws_security_group" "stal_web_sg" {
  name        = "stal_web_sg"
  description = "Default web: 22, 80, 443"
  vpc_id      = aws_vpc.stal_vpc.id

  ingress {
    description = "SSH from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

    ingress {
    description = "HTTP from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

    ingress {
    description = "HTTPS from VPC"
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

  tags = {
    Name = "stal_web_sg"
  }
}

# # assuming we're creating the main DNS zone manually
# # and keeping its id in terraform.tfvars
# data "aws_route53_zone" "stal_zone" {
#   name         = var.dns_zone
#   private_zone = false 
# }

resource "aws_route53_record" "fqdn" {
  zone_id = var.dns_zone_id
  name    = "${var.project_name}.${var.dns_zone}"
  type    = "CNAME"
  ttl     = "300"
  records = [aws_instance.stal_instance.public_dns]
}