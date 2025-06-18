terraform {
  backend "s3" {
    bucket         = "aws15june25souvikexam" # Can be passed via `-backend-config= "bucket"=<Bucket Name>
    key            = "aws15june25.tfstate"   # Can be passed via `-backend-config=`"key"=<Key Name>` in the `init` command.
    region         = "ap-southeast-1"        # Can be passed via `-backend-config= "region"=<Region Name>
    dynamodb_table = "aws15june25-terraformlock"
    encrypt        = true
  }
}
