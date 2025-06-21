# Create a Public Key & Upload to AWS
resource "aws_key_pair" "key" {
  key_name   = "${var.project}-key"
  public_key = file("~/.ssh/id_rsa.pub") # Private_key=~/.ssh/id_rsa
  tags = {
    Name = "${var.project}-Key"
  }
}

# Create EC2 Instance for VPC in Subnet1 & Install Nginx & copy custom index.html
resource "aws_instance" "subnet1_instance1" {
  subnet_id                   = aws_subnet.subnet[0].id
  vpc_security_group_ids      = [aws_security_group.vpc_sg.id]
  key_name                    = aws_key_pair.key.key_name
  ami                         = var.ami_id
  availability_zone           = var.zone[0]
  instance_type               = var.instance_type
  associate_public_ip_address = true
  depends_on                  = [aws_security_group.vpc_sg]
  tags = {
    Name = "subnet1-instance1"
  }
  root_block_device {
    delete_on_termination = true
    volume_size           = var.volume_config.v_size
    volume_type           = var.volume_config.v_type
  }

  lifecycle {
    create_before_destroy = true
  }

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("~/.ssh/id_rsa")
    host        = self.public_ip
  }

  provisioner "file" {
    source      = "/home/sb/Terraform/aws/s3-static-website/index.html"
    destination = "/home/ubuntu/index.html"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update",
      "sudo apt install nginx -y",
      "sudo rm -f /var/www/html/index.html",
      "sudo cp /home/ubuntu/index.html /var/www/html/",
      "sudo systemctl start nginx",
    ]
  }
}

# Create EC2 Instance for VPC in Subnet2 & Install Apache2 & copy custom index.html
resource "aws_instance" "subnet2_instance1" {
  subnet_id                   = aws_subnet.subnet[1].id
  vpc_security_group_ids      = [aws_security_group.vpc_sg.id]
  key_name                    = aws_key_pair.key.key_name
  ami                         = var.ami_id
  availability_zone           = var.zone[1]
  instance_type               = var.instance_type
  associate_public_ip_address = true
  depends_on                  = [aws_security_group.vpc_sg]
  tags = {
    Name = "subnet2-instance"
  }
  root_block_device {
    delete_on_termination = true
    volume_size           = var.volume_config.v_size
    volume_type           = var.volume_config.v_type
  }

  lifecycle {
    create_before_destroy = true
  }

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("~/.ssh/id_rsa")
    host        = self.public_ip
  }

  provisioner "file" {
    source      = "./index.html"
    destination = "/home/ubuntu/index.html"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update",
      "sudo apt install apache2 -y",
      "sudo rm -f /var/www/html/index.html",
      "sudo cp /home/ubuntu/index.html /var/www/html/",
      "sudo systemctl start apache2",
    ]
  }
}