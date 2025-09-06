output "instance_public_ip" {
  value = [for i in aws_instance.instance : i.public_ip]
}

output "ami_id" {
  value = data.aws_ami.ubuntu22.id
}

output "available_zones" {
  value = data.aws_availability_zones.available_zone.names
}
