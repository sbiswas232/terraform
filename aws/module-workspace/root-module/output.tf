output "subnet_cidr" {
  value = module.aws_vpc.subnet_cidr
}

output "sg_id" {
  value = module.aws_vpc.sg_id
}

output "public_ip" {
  value = module.aws_vpc.public_ip
}