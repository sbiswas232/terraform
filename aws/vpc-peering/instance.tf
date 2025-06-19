# Create Security Group for VPC(Dev-Vpc & Test-Vpc)
resource "aws_security_group" "vpc_sg" {
  count  = length(var.vpc_cidr)
  name   = "${var.tag_name[count.index]}-vpc-sg"
  vpc_id = aws_vpc.vpc[count.index].id
  tags = {
    Name = "${var.project}-${var.tag_name[count.index]}-sg"
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

# Create EC2 Instance for Dev-VPC Public-Subnet
resource "aws_instance" "dev_public" {
  subnet_id                   = aws_subnet.subnet[0].id
  ami                         = var.ami
  instance_type               = var.instance_type[0]
  availability_zone           = var.zone[0]
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.vpc_sg[0].id]
  key_name                    = var.key_name
  depends_on                  = [aws_security_group.vpc_sg[0]]
  root_block_device {
    delete_on_termination = true
    volume_size           = var.volume_config.v_size
    volume_type           = var.volume_config.v_type
  }

  user_data = <<-EOF
            #!/bin/bash
            sudo apt-get update -y
            sudo apt install apache2 -y
            sudo systemctl start apache2
          EOF
  tags = {
    Name = "${var.project}-${var.tag_name[0]}-instance1"
  }
}

# Create EC2 Instance for Test-VPC Public-Subnet
resource "aws_instance" "test_public" {
  subnet_id                   = aws_subnet.subnet[1].id
  ami                         = var.ami
  instance_type               = var.instance_type[1]
  availability_zone           = var.zone[1]
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.vpc_sg[1].id]
  key_name                    = var.key_name
  depends_on                  = [aws_security_group.vpc_sg[1]]
  root_block_device {
    delete_on_termination = true
    volume_size           = var.volume_config.v_size
    volume_type           = var.volume_config.v_type
  }

  tags = {
    Name = "${var.project}-${var.tag_name[1]}-instance1"
  }
}
