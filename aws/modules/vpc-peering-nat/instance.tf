# Create EC2 Instance in VPC1 Public Subnet
resource "aws_instance" "instance_vpc1_publicsubnet" {
  vpc_security_group_ids      = [aws_security_group.sg[0].id]
  subnet_id                   = aws_subnet.subnet_vpc1[0].id
  instance_type               = var.instance_type
  ami                         = data.aws_ami.ubuntu22.id
  key_name                    = var.key_name
  availability_zone           = data.aws_availability_zones.available_zone.names[0]
  associate_public_ip_address = true
  depends_on                  = [aws_security_group.sg[0]]
  tags = {
    Name = "${var.project}-vpc1-publicsubnet-instance"
  }

  root_block_device {
    delete_on_termination = true
    volume_type           = var.volume_type
    volume_size           = var.volume_size
  }
}

# Create EC2 Instance in VPC2 Private Subnet
resource "aws_instance" "instance_vpc2_privatesubnet" {
  vpc_security_group_ids      = [aws_security_group.sg[1].id]
  subnet_id                   = aws_subnet.subnet_vpc2[1].id
  instance_type               = var.instance_type
  ami                         = data.aws_ami.ubuntu22.id
  key_name                    = var.key_name
  availability_zone           = data.aws_availability_zones.available_zone.names[1]
  associate_public_ip_address = false
  depends_on                  = [aws_security_group.sg[1]]
  tags = {
    Name = "${var.project}-vpc2-privatesubnet-instance"
  }

  root_block_device {
    delete_on_termination = true
    volume_type           = var.volume_type
    volume_size           = var.volume_size
  }
}

