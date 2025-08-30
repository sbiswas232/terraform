variable "project" {
  type    = string
  default = ""
}

variable "region" {
  type    = string
  default = ""
}

variable "vpc_cidr" {
  type    = string
  default = ""
}

variable "zone" {
  type    = list(string)
  default = [""]
}

variable "credential" {
  type = object({
    access_key = string
    secret_key = string
  })
  default = {
    access_key = ""
    secret_key = ""
  }
  sensitive = true
}

variable "ami" {
  type    = string
  default = ""
}

variable "instance_type" {
  type    = string
  default = ""
}

variable "key_name" {
  type    = string
  default = ""
}

variable "volume_size" {
  type    = number
  default = 8
}

variable "volume_type" {
  type    = string
  default = ""
}