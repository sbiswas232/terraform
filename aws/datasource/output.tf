output "ubuntu22_ami_id" {
  value = data.aws_ami.ubuntu22.id
}

output "ubuntu22_ami_name" {
  value = data.aws_ami.ubuntu22.name
}

output "available_zones" {
  value = data.aws_availability_zones.zone_names.names
}