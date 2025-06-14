provider "aws" {
  region = var.region
}

resource "aws_vpc" "prov_vpc" {
  cidr_block = var.vpc_cidr
  tags = {
    Name    = "${var.project}-Vpc"
    Project = "Terraform-Provisioner"
  }
}

resource "aws_subnet" "prov_subnet" {
  vpc_id            = aws_vpc.prov_vpc.id
  cidr_block        = var.subnet_cidr
  availability_zone = var.zone
  tags = {
    Name    = "${var.project}-Subnet"
    Project = "Terraform-Provisioner"
  }
}

resource "aws_internet_gateway" "prov_igw" {
  vpc_id = aws_vpc.prov_vpc.id
  tags = {
    Name    = "${var.project}-Igw"
    Project = "Terraform-Provisioner"
  }
}

resource "aws_route_table" "prov_route" {
  vpc_id = aws_vpc.prov_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.prov_igw.id
  }
  tags = {
    Name    = "${var.project}-Route"
    Project = "Terraform-Provisioner"
  }
}

resource "aws_route_table_association" "prov_subnet" {
  route_table_id = aws_route_table.prov_route.id
  subnet_id      = aws_subnet.prov_subnet.id
}

resource "aws_security_group" "prov_vpc_sg" {
  name   = "prov-vpc-sg"
  vpc_id = aws_vpc.prov_vpc.id
  tags = {
    Name    = "${var.project}-sg"
    Project = "Terraform-Provisioner"
  }
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "Ping"
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "Http"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    description = "Outbound-Traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_key_pair" "prov_key" {
  key_name   = "${var.project}-key"
  public_key = file("~/.ssh/id_rsa.pub") # Private_key=~/.ssh/id_rsa
  tags = {
    Name    = "${var.project}-Key"
    Project = "Terraform-Provisioner"
  }
}