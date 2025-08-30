# Create EC2 Instance
resource "aws_instance" "instance" {
  count                       = length(var.zone)
  vpc_security_group_ids      = [aws_security_group.sg.id]
  subnet_id                   = aws_subnet.subnet[count.index].id
  instance_type               = var.instance_type
  ami                         = var.ami
  key_name                    = var.key_name
  availability_zone           = element(var.zone, count.index)
  associate_public_ip_address = true
  depends_on                  = [aws_security_group.sg]
  tags = {
    "Name" = "${var.project}-${terraform.workspace}-instance"
  }

  root_block_device {
    delete_on_termination = true
    volume_size           = var.volume_size
    volume_type           = var.volume_type
  }
}
