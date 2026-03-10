terraform {
  backend "s3" {
    bucket       = "souvikexam23-backend-s3bucket09mar26"
    region       = "ap-southeast-1"
    key          = "directory/default/terraform.tfstate"
    encrypt      = true
    use_lockfile = true
  }
}