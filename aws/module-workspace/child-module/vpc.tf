# Create VPC
resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr
  instance_tenancy     = "default"
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name = "${var.project}-${terraform.workspace}vpc"
  }
}

# Create Subnet
resource "aws_subnet" "subnet" {
  count             = length(var.zone)
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = cidrsubnet(aws_vpc.vpc.cidr_block, 4, count.index + 1)
  availability_zone = element(var.zone, count.index)
  tags = {
    Name = "${var.project}-${terraform.workspace}-subnet${count.index + 1}"
  }
}

# Create IGW
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    "Name" = "${var.project}-${terraform.workspace}-igw"
  }
}

# Create Route Table
resource "aws_route_table" "route" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    "Name" = "${var.project}-${terraform.workspace}-route"
  }
}

# Create Subnet Association
resource "aws_route_table_association" "subnet_association" {
  count          = length(var.zone)
  route_table_id = aws_route_table.route.id
  subnet_id      = element(aws_subnet.subnet[*].id, count.index)
}

# Create Security Group
resource "aws_security_group" "sg" {
  vpc_id = aws_vpc.vpc.id
  name   = "${var.project}-${terraform.workspace}-sg"
  tags = {
    "Name" = "${var.project}-${terraform.workspace}-sg"
  }
  ingress {
    description = "SSH"
    to_port     = 22
    from_port   = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "Http"
    to_port     = 80
    from_port   = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    description = "Outbound Traffic"
    to_port     = 0
    from_port   = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


