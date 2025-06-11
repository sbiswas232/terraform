# Create Two VPC for peering connection(Dev-vpc & Test vpc)
resource "aws_vpc" "vpc" {
  count      = length(var.vpc_cidr)
  cidr_block = var.vpc_cidr[count.index]
  tags = {
    Name        = "${var.project}-${var.tag_name[count.index]}-Vpc"
    Environment = "${var.tag_name[count.index]}-Vpc"
  }
}

# Create four Subnet(Two for each Dev-vpc & Test-vpc)
resource "aws_subnet" "subnet" {
  count             = length(var.subnet_cidr)
  vpc_id            = element(aws_vpc.vpc[*].id, count.index % length(aws_vpc.vpc))
  cidr_block        = var.subnet_cidr[count.index]
  availability_zone = var.zone
  tags = {
    Name = "${var.subnet_name[count.index]}-Subnet"
  }
}
# Create IGW for Dev-vpc & Test-vpc
resource "aws_internet_gateway" "igw" {
  count  = length(var.vpc_cidr)
  vpc_id = aws_vpc.vpc[count.index].id
  tags = {
    Name = "${var.tag_name[count.index]}-igw"
  }
}

# Create Route Table
resource "aws_route_table" "dev_vpc_route" {
  vpc_id = aws_vpc.vpc[0].id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw[0].id
  }
  route {
    cidr_block = var.vpc_cidr[1]
    gateway_id = aws_vpc_peering_connection.dev_vpc.id
  }
  tags = {
    Name = "${var.tag_name[0]}-Route"
  }
}

resource "aws_route_table" "test_vpc_route" {
  vpc_id = aws_vpc.vpc[1].id
  route {
    cidr_block = var.vpc_cidr[0]
    gateway_id = aws_vpc_peering_connection.dev_vpc.id
  }
  tags = {
    Name = "${var.tag_name[1]}-Route"
  }
}

# Create Route Table Association
resource "aws_route_table_association" "dev_vpc" {
  route_table_id = aws_route_table.dev_vpc_route.id
  subnet_id      = aws_subnet.subnet[0].id
}

resource "aws_route_table_association" "test_vpc" {
  route_table_id = aws_route_table.test_vpc_route.id
  subnet_id      = aws_subnet.subnet[1].id
}

# Create Peering Connection of Dev-VPC & Test-VPC
resource "aws_vpc_peering_connection" "dev_vpc" {
  peer_vpc_id = aws_vpc.vpc[1].id
  vpc_id      = aws_vpc.vpc[0].id
  auto_accept = true
  tags = {
    Name = "${var.tag_name[0]}-Peer"
  }
}