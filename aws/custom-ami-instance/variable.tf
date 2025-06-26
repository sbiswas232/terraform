variable "project" {
  type    = string
  default = "aws25june25"
}

variable "region" {
  type    = string
  default = "ap-southeast-1"
}

variable "vpc_cidr" {
  type    = string
  default = "172.16.16.0/20"
}

variable "zone" {
  type    = list(string)
  default = ["ap-southeast-1a", "ap-southeast-1b"]
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "ami" {
  type    = string
  default = "ami-02c7683e4ca3ebf58"
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