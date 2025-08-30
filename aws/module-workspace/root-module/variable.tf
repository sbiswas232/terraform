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
    "dev"  = "t2.micro"
    "test" = "t2.nano"
  }
}

variable "volume_size" {
  type = map(number)
  default = {
    "dev"  = 10
    "test" = 8
  }
}

variable "volume_type" {
  type = map(string)
  default = {
    "dev"  = "gp3"
    "test" = "gp2"
  }
}