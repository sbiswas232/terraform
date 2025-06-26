output "instance_public_ip" {
  value = aws_instance.instance.public_ip
}

output "custom_instance_public_ip" {
  value = [for i in aws_instance.custom_ami_instance : i.public_ip]
}