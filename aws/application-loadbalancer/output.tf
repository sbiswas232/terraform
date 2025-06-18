output "lb_dns_name" {
  value = aws_lb.vpc_lb.dns_name
}

output "subnet1_instance1_public_ip" {
  value = aws_instance.subnet1_instance1.public_ip
}

output "subnet2_instance1_public_ip" {
  value = aws_instance.subnet2_instance1.public_ip
}