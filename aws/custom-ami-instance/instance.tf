# Create EC2 Instance for Apache Webserver 
resource "aws_instance" "instance" {
  vpc_security_group_ids      = [aws_security_group.sg.id]
  subnet_id                   = aws_subnet.subnet[0].id
  instance_type               = var.instance_type
  ami                         = var.ami
  key_name                    = var.key_name
  associate_public_ip_address = true
  availability_zone           = var.zone[0]
  depends_on                  = [aws_security_group.sg]
  tags = {
    "Name" = "${var.project}-instance"
  }

  root_block_device {
    delete_on_termination = true
    volume_size           = var.volume_config.v_size
    volume_type           = var.volume_config.v_type
  }
  user_data_base64 = base64encode(file("./userdata.sh"))
}

# Create Custom-AMI of Apache Webserver
resource "aws_ami_from_instance" "custom_ami" {
  name               = "${var.project}-ami"
  source_instance_id = aws_instance.instance.id
  tags = {
    "Name" = "${var.project}-ami"
  }
}

# Create Instance from Custom-AMI of Apache WebServer
resource "aws_instance" "custom_ami_instance" {
  count                       = length(var.zone)
  vpc_security_group_ids      = [aws_security_group.sg.id]
  subnet_id                   = aws_subnet.subnet[count.index].id
  instance_type               = var.instance_type
  ami                         = aws_ami_from_instance.custom_ami.id
  key_name                    = var.key_name
  associate_public_ip_address = true
  availability_zone           = element(var.zone, count.index)
  depends_on                  = [aws_ami_from_instance.custom_ami]
  tags = {
    "Name" = "${var.project}ami-subnet${count.index + 1}-instance"
  }

  root_block_device {
    delete_on_termination = true
    volume_size           = var.volume_config.v_size
    volume_type           = var.volume_config.v_type
  }
}


