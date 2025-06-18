output "vpc_id" {
  value = [for vid in aws_vpc.vpc : vid.id]
}

output "subnet_id" {
  value = [for sid in aws_subnet.subnet : sid.id]
}