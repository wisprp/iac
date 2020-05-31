variable "project_name" {
    default = "sample"
}
variable "instance_type" {
    default = "t3a.medium"
}
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
  ami           = data.aws_ami.ubuntu_lts.id
  instance_type = var.instance_type
  subnet_id     = aws_subnet.stal_subnet.id
  
  associate_public_ip_address = true

  tags          = {
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