# Create a VPC
resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = "${var.project}-vpc"
  }
}

# Create two Subnet(Subnet1 & Subnet2) 
resource "aws_subnet" "subnet" {
  count             = length(var.subnet_cidr)
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.subnet_cidr[count.index]
  availability_zone = var.zone[count.index]
  tags = {
    Name = "${var.project}-${var.subnet_name[count.index]}"
  }
}

# Create Internet-Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "${var.project}-igw"
  }
}

# Create two Route-Table & Associate wih Subnet1 & Subnet2
resource "aws_route_table" "route" {
  count  = length(var.route_name)
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "${var.project}-${var.route_name[count.index]}"
  }
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

# Route1 Associate with Subnet1
resource "aws_route_table_association" "route1_subnet1" {
  route_table_id = aws_route_table.route[0].id
  subnet_id      = aws_subnet.subnet[0].id
}

# Route2 Associate with Subnet2
resource "aws_route_table_association" "route2_subnet2" {
  route_table_id = aws_route_table.route[1].id
  subnet_id      = aws_subnet.subnet[1].id
}

# Security Group with VPC
resource "aws_security_group" "vpc_sg" {
  name   = "${var.project}-sg"
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "${var.project}-sg"
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