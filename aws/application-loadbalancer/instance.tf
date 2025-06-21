# # Create EC2 Instance for Subnet1
# resource "aws_instance" "subnet1_instance1" {
#   subnet_id                   = aws_subnet.subnet[0].id
#   ami                         = var.ami_id
#   instance_type               = var.instance_type
#   availability_zone           = var.zone[0]
#   associate_public_ip_address = true
#   vpc_security_group_ids      = [aws_security_group.vpc_sg.id]
#   key_name                    = var.key_name
#   depends_on                  = [aws_security_group.vpc_sg]
#   root_block_device {
#     delete_on_termination = true
#     volume_size           = var.volume_config.v_size
#     volume_type           = var.volume_config.v_type
#   }

#   user_data = <<-EOF
#             #!/bin/bash
#             sudo apt-get update 
#             sudo apt install apache2 -y
#             sudo echo "<html><h1>Welcome to Apache2 Web Server on-$(hostname)!</h1></html>" > /var/www/html/index.html
#             sudo systemctl start apache2
#           EOF
#   tags = {
#     Name = "${var.project}-subnet1-instance1"
#   }
#   lifecycle {
#     create_before_destroy = true
#   }
# }

# # Create EC2 Instance for Subnet2
# resource "aws_instance" "subnet2_instance1" {
#   subnet_id                   = aws_subnet.subnet[1].id
#   ami                         = var.ami_id
#   instance_type               = var.instance_type
#   availability_zone           = var.zone[1]
#   associate_public_ip_address = true
#   vpc_security_group_ids      = [aws_security_group.vpc_sg.id]
#   key_name                    = var.key_name
#   depends_on                  = [aws_security_group.vpc_sg]
#   root_block_device {
#     delete_on_termination = true
#     volume_size           = var.volume_config.v_size
#     volume_type           = var.volume_config.v_type
#   }

#   user_data = <<-EOF
#             #!/bin/bash
#             sudo apt-get update 
#             sudo apt install nginx -y
#             sudo echo "<html><h1>Welcome to Nginx Web Server on-$(hostname)!</h1></html>" > /var/www/html/index.html
#             sudo systemctl start nginx
#           EOF
#   tags = {
#     Name = "${var.project}-subnet2-instance1"
#   }
#   lifecycle {
#     create_before_destroy = true
#   }
# }

