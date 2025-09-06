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

variable "instance_type" {
  type = map(string)
  default = {
    "dev"  = ""
    "test" = ""
  }
}

variable "volume_size" {
  type = map(number)
  default = {
    "dev"  = 0
    "test" = 0
  }
}

variable "volume_type" {
  type = map(string)
  default = {
    "dev"  = ""
    "test" = ""
  }
}

variable "key_name" {
  type    = string
  default = ""
}