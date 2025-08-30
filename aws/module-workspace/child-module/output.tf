output "subnet_cidr" {
  value = aws_subnet.subnet[*].cidr_block
}

output "sg_id" {
  value = aws_security_group.sg.id
}

output "public_ip" {
  value = [for i in aws_instance.instance[*] : i.public_ip]
}