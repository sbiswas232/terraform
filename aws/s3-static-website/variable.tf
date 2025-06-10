variable "project" {
  type    = string
  default = "devops30may"
}

variable "region" {
  type    = list(string)
  default = ["ap-southeast-1", "ap-south-1"]
}

variable "bucket_name" {
  type    = list(string)
  default = ["souvikexam23", "sbiswas232"]
}

variable "source_html" {
  type    = list(string)
  default = ["./index.html", "./index1.html"]
}

variable "tag_name" {
  type    = list(string)
  default = ["Dev", "Test"]
}