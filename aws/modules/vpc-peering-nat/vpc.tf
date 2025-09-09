# Create VPC (VPC1 & VPC2)
resource "aws_vpc" "vpc" {
  count                = 2
  cidr_block           = var.vpc_cidr[count.index]
  instance_tenancy     = "default"
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name = "${var.project}-vpc${count.index + 1}"
  }
}

# Create Subnets for VPC1 & VPC2
resource "aws_subnet" "subnet_vpc1" {
  count             = 2
  vpc_id            = aws_vpc.vpc[0].id
  cidr_block        = cidrsubnet(aws_vpc.vpc[0].cidr_block, 4, count.index)
  availability_zone = data.aws_availability_zones.available_zone.names[count.index]
  tags = {
    Name = "${var.project}-vpc1-${var.subnet[count.index]}-subnet"
  }
}

resource "aws_subnet" "subnet_vpc2" {
  count             = 2
  vpc_id            = aws_vpc.vpc[1].id
  cidr_block        = cidrsubnet(aws_vpc.vpc[1].cidr_block, 4, count.index)
  availability_zone = data.aws_availability_zones.available_zone.names[count.index]
  tags = {
    Name = "${var.project}-vpc2-${var.subnet[count.index]}-subnet"
  }
}

# Create IGW
resource "aws_internet_gateway" "igw" {
  count  = 2
  vpc_id = aws_vpc.vpc[count.index].id
  tags = {
    Name = "${var.project}-vpc${count.index + 1}-igw"
  }
}

# Create Route Table
resource "aws_route_table" "public_route_vpc1" {
  vpc_id = aws_vpc.vpc[0].id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw[0].id
  }
  route {
    cidr_block = var.vpc_cidr[1]
    gateway_id = aws_vpc_peering_connection.peer.id
  }
  tags = {
    Name = "${var.project}-public-route-vpc1"
  }
}

resource "aws_route_table" "public_route_vpc2" {
  vpc_id = aws_vpc.vpc[1].id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw[1].id
  }
  route {
    cidr_block = var.vpc_cidr[0]
    gateway_id = aws_vpc_peering_connection.peer.id
  }
  tags = {
    Name = "${var.project}-public-route-vpc2"
  }
}

resource "aws_route_table" "private_route_vpc1" {
  vpc_id = aws_vpc.vpc[0].id
  route {
    cidr_block = var.vpc_cidr[1]
    gateway_id = aws_vpc_peering_connection.peer.id
  }
  tags = {
    Name = "${var.project}-private_route_vpc1"
  }
}

resource "aws_route_table" "private_route_vpc2" {
  vpc_id = aws_vpc.vpc[1].id
  route {
    cidr_block = var.vpc_cidr[0]
    gateway_id = aws_vpc_peering_connection.peer.id
  }
  tags = {
    Name = "${var.project}-private_route_vpc2"
  }
}

# Create Subnet Association
resource "aws_route_table_association" "public_route_vpc1" {
  route_table_id = aws_route_table.public_route_vpc1.id
  subnet_id      = aws_subnet.subnet_vpc1[0].id
}

resource "aws_route_table_association" "public_route_vpc2" {
  route_table_id = aws_route_table.public_route_vpc2.id
  subnet_id      = aws_subnet.subnet_vpc2[0].id
}

resource "aws_route_table_association" "private_route_vpc1" {
  route_table_id = aws_route_table.private_route_vpc1.id
  subnet_id      = aws_subnet.subnet_vpc1[1].id
}

resource "aws_route_table_association" "private_route_vpc2" {
  route_table_id = aws_route_table.private_route_vpc2.id
  subnet_id      = aws_subnet.subnet_vpc2[1].id
}

# Create Peering Connection of VPC1 & VPC2
resource "aws_vpc_peering_connection" "peer" {
  peer_vpc_id = aws_vpc.vpc[0].id
  vpc_id      = aws_vpc.vpc[1].id
  auto_accept = true
  tags = {
    Name = "${var.project}-Peer"
  }
}

# Create Security Group
resource "aws_security_group" "sg" {
  count  = 2
  vpc_id = aws_vpc.vpc[count.index].id
  name   = "${var.project}-vpc${count.index + 1}-sg"
  tags = {
    "Name" = "${var.project}-vpc${count.index + 1}-sg"
  }
  ingress {
    description = "SSH"
    to_port     = 22
    from_port   = 22
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


