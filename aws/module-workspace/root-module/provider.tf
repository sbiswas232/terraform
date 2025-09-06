terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.67.0"
    }
  }
}

provider "aws" {
  region     = var.region
  access_key = var.credential.access_key
  secret_key = var.credential.secret_key
}