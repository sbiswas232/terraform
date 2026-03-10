variable "project" {
  type    = string
  default = "terraform-s3backend-10may26"
}

variable "region" {
  type    = string
  default = ""
}

variable "credential" {
  type = object({
    access-key = string
    secret-key = string
  })
  default = {
    access-key = ""
    secret-key = ""
  }
  sensitive = true
}

variable "vpc-cidr" {
  type    = string
  default = ""
}

variable "zone" {
  type    = list(string)
  default = [""]
}