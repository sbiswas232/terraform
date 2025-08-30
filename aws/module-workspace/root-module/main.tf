module "aws_vpc" {
  source        = "../modules/child_resource"
  project       = "30aug25"
  vpc_cidr      = "172.16.0.0/20"
  region        = "ap-southeast-1"
  ami           = "ami-0933f1385008d33c4"
  key_name      = "*****"
  zone          = ["ap-southeast-1a", "ap-southeast-1b"]
  instance_type = lookup(var.instance_type, terraform.workspace, "t2.nano")
  volume_type   = lookup(var.volume_type, terraform.workspace, "gp2")
  volume_size   = lookup(var.volume_size, terraform.workspace, 8)
  credential = { 
    access_key = var.credential.access_key
    secret_key = var.credential.secret_key
  }
}
