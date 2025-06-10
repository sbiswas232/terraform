# Create S3-Bucket Using Random Provider & copy index.html for Website

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    random = {
      source = "hashicorp/random"
      version = "3.6.3"
    }
  }
}
provider "aws" {
  region = "ap-southeast-1"
}

resource "random_id" "s3_id" {
  byte_length = 8
}

output "rand_id" {
  value = random_id.s3_id.hex
}

resource "aws_s3_bucket" "my_bucket" {
  bucket = "sbiswas232-${random_id.s3_id.hex}"
}

resource "aws_s3_bucket_public_access_block" "my_acl" {
  bucket = aws_s3_bucket.my_bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_object" "my_files" {
  bucket = aws_s3_bucket.my_bucket.id
  key    = "index.html"
  source = "./index.html"
  content_type = "text/html"
}

resource "aws_s3_bucket_website_configuration" "my_website" {
  bucket = aws_s3_bucket.my_bucket.id

  index_document {
    suffix = "index.html"
  }
}

resource "aws_s3_bucket_policy" "my_policy" {
  bucket = aws_s3_bucket.my_bucket.id
  policy = jsonencode(
    {
      Version = "2012-10-17",
      Statement = [
        {
          Sid = "PublicReadGetObject",
          Effect = "Allow",
          Principal = "*",
          Action = "s3:GetObject",
          Resource = "arn:aws:s3:::${aws_s3_bucket.my_bucket.id}/*"
        }
      ]
    }
  )
}

output "website" {
  value = aws_s3_bucket_website_configuration.my_website.website_endpoint
}