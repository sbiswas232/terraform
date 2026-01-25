terraform {
  backend "local" {
    path = "/tmp/terraform-backend/terraform.tfstate"
  }
}
