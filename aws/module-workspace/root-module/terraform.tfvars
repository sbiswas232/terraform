project  = "31aug25"
region   = "ap-southeast-1"
vpc_cidr = "172.16.16.0/20"
key_name = "#######"

instance_type = {
  "dev"  = "t2.micro"
  "test" = "t2.nano"
}

volume_type = {
  "dev"  = "gp3"
  "test" = "gp2"
}

volume_size = {
  "dev"  = 10
  "test" = 8
}
