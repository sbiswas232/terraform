# Create EC2 Instance for Prov-VPC
resource "aws_instance" "prov_vpc_instance" {
  subnet_id                   = aws_subnet.prov_subnet.id
  vpc_security_group_ids      = [aws_security_group.prov_vpc_sg.id]
  key_name                    = aws_key_pair.prov_key.key_name
  ami                         = var.ami_id
  availability_zone           = var.zone
  instance_type               = var.instance_type
  associate_public_ip_address = true
  tags = {
    Name    = "${var.project}-Prov-Instance1"
    Project = "Terraform-Provisioner"
  }
  root_block_device {
    delete_on_termination = true
    volume_size           = var.volume_config.v_size
    volume_type           = var.volume_config.v_type
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
      "sudo apt-get update -y",
      "sudo apt install nginx -y ",
      "sudo cp -Rv /home/ubuntu/index.html /var/www/html/",
      "sudo systemctl start nginx",
    ]
  }
}
