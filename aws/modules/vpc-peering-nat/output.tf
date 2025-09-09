output "zone" {
  value = data.aws_availability_zones.available_zone.names
}

output "ami_id" {
  value = data.aws_ami.ubuntu22.id
}