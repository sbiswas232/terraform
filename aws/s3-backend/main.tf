resource "aws_vpc" "vpc" {
  count      = length(var.vpc_cidr)
  cidr_block = var.vpc_cidr[count.index]
  tags = {
    Name = "${var.project}-${var.tag_name[count.index]}-VPC"
  }
}

resource "aws_subnet" "subnet" {
  count             = length(var.subnet_cidr)
  vpc_id            = element(aws_vpc.vpc[*].id, count.index % length(aws_vpc.vpc))
  cidr_block        = var.subnet_cidr[count.index]
  availability_zone = var.zone[count.index]
  tags = {
    Name = "${var.project}-${var.tag_name[count.index]}-Subnet"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc[0].id
  tags = {
    Name = "${var.project}-${var.tag_name[0]}-Igw1"
  }
}
