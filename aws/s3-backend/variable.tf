variable "project" {
  type    = string
  default = "aws15june25"
}

variable "region" {
  type    = string
  default = "ap-southeast-1"
}

variable "vpc_cidr" {
  type    = list(string)
  default = ["172.16.16.0/20", "172.16.32.0/20"]
}

variable "subnet_cidr" {
  type    = list(string)
  default = ["172.16.16.0/24", "172.16.32.0/24"]
}

variable "zone" {
  type    = list(string)
  default = ["ap-southeast-1a", "ap-southeast-1b"]
}

variable "tag_name" {
  type    = list(string)
  default = ["Dev", "Prod"]
}