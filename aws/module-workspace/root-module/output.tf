output "public_ip" {
  value = module.aws_ec2.instance_public_ip
}

output "ami_id" {
  value = module.aws_ec2.ami_id
}
