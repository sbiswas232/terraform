output "prov_vpc_instance_public_ip" {
  value = aws_instance.prov_vpc_instance.public_ip
}