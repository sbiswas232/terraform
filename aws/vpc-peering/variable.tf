variable "project" {
  type    = string
  default = "aws10july25"
}

variable "vpc_cidr" {
  type    = list(string)
  default = ["10.0.0.0/16", "10.1.0.0/16"]
}

variable "subnet_cidr" {
  type    = list(string)
  default = ["10.0.0.0/24", "10.1.0.0/24", "10.0.1.0/24", "10.1.1.0/24"]
}

variable "tag_name" {
  type    = list(string)
  default = ["Dev", "Test"]
}

variable "subnet_name" {
  type    = list(string)
  default = ["Dev-Public", "Test-Public", "Dev-Private", "Test-Private"]
}

variable "zone" {
  type    = string
  default = "ap-southeast-1b"
}

variable "ami" {
  type    = string
  default = "ami-069cb3204f7a90763"
}

variable "instance_type" {
  type    = list(string)
  default = ["t2.micro", "t2.nano"]
}

variable "key_name" {
  type    = string
  default = "######"
}
