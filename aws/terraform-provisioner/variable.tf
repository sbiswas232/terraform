variable "project" {
  type    = string
  default = "aws14june25"
}

variable "region" {
  type    = string
  default = "ap-southeast-1"
}

variable "vpc_cidr" {
  type    = string
  default = "172.1.0.0/16"
}

variable "subnet_cidr" {
  type    = string
  default = "172.1.0.0/24"
}

variable "zone" {
  type    = string
  default = "ap-southeast-1b"
}

variable "ami_id" {
  type    = string
  default = "ami-02c7683e4ca3ebf58"
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
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
