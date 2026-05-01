variable "project" {
  type    = string
  default = ""
}

variable "location" {
  type    = string
  default = ""
}

variable "vnet-cidr" {
  type    = string
  default = ""
}

variable "subnet-cidr" {
  type = list(string)
  default = [ "", "" ]
}