variable "project" {
  type    = string
  default = "aws18june25"
}

variable "region" {
  type    = string
  default = "ap-southeast-1"
}

variable "vpc_cidr" {
  type    = string
  default = "172.16.16.0/20"
}

variable "subnet_cidr" {
  type    = list(string)
  default = ["172.16.16.0/24", "172.16.17.0/24"]
}

variable "zone" {
  type    = list(string)
  default = ["ap-southeast-1a", "ap-southeast-1b"]
}

variable "subnet_name" {
  type    = list(string)
  default = ["subnet1", "subnet2"]
}

variable "route_name" {
  type    = list(string)
  default = ["route1", "route2"]
}

variable "ami_id" {
  type    = string
  default = "ami-069cb3204f7a90763"
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "key_name" {
  type    = string
  default = ""
}

variable "volume_config" {
  type = object({
    v_size = number
    v_type = string
  })
  default = {
    v_size = 8
    v_type = "gp2"
  }
}
