module "aws_ec2" {
  source        = "../modules/ec2"    # source = "git::https://github.com/sbiswas232/terraform-aws-vpc.git?ref=v1.0.0" (If Source is from Github)
  project       = var.project
  vpc_cidr      = var.vpc_cidr
  key_name      = var.key_name
  instance_type = lookup(var.instance_type, terraform.workspace, "t2.nano")
  volume_type   = lookup(var.volume_type, terraform.workspace, "gp2")
  volume_size   = lookup(var.volume_size, terraform.workspace, 8)
}
