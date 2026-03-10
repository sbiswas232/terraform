terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>6.0.0"
    }
  }
}

provider "aws" {
  region     = var.region
  access_key = var.credential.access-key
  secret_key = var.credential.secret-key
}