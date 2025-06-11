resource "aws_security_group" "sg0" {
  vpc_id = aws_vpc.vpc[0].id
  tags = {
    Name = "${var.project}-${var.tag_name[0]}-sg"
  }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 80
    to_port     = 80
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

resource "aws_security_group" "sg1" {
  vpc_id = aws_vpc.vpc[1].id
  tags = {
    Name = "${var.project}-${var.tag_name[1]}-sg"
  }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 80
    to_port     = 80
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

# Create EC2 Instance for Dev-VPC Public-Subnet
resource "aws_instance" "dev_public" {
  subnet_id                   = aws_subnet.subnet[0].id
  ami                         = var.ami
  instance_type               = var.instance_type[0]
  availability_zone           = var.zone
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.sg0.id]
  key_name                    = var.key_name
  depends_on                  = [aws_security_group.sg0]
  user_data                   = <<-EOF
            #!/bin/bash
            sudo apt-get update
            sudo apt install nginx -y
            sudo systemctl start nginx
            EOF
  tags = {
    Name = "${var.project}-${var.tag_name[0]}-instance1"
  }
}

# Create EC2 Instance for Test-VPC Public-Subnet
resource "aws_instance" "test_public" {
  subnet_id                   = aws_subnet.subnet[1].id
  ami                         = var.ami
  instance_type               = var.instance_type[0]
  availability_zone           = var.zone
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.sg1.id]
  key_name                    = var.key_name
  depends_on                  = [aws_security_group.sg1]
  tags = {
    Name = "${var.project}-${var.tag_name[1]}-instance1"
  }
}
