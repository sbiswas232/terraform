resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc-cidr
  instance_tenancy     = "default"
  enable_dns_hostnames = true
  tags = {
    project = "${var.project}"
    Name    = "Default-WorkSpace"
  }
}

resource "aws_subnet" "subnet" {
  count             = length(var.zone)
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = cidrsubnet(aws_vpc.vpc.cidr_block, 4, count.index)
  availability_zone = var.zone[count.index]
  tags = {
    Name = "${var.project}-subnet${count.index + 1}"
  }
}
