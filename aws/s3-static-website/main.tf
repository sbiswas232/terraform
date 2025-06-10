# Create Two S3-Bucket & Static Website & Copy two different index.html File

resource "aws_s3_bucket" "bucket" {
  count  = length(var.bucket_name)
  bucket = "${var.project}-${var.bucket_name[count.index]}"

  tags = {
    "Company"     = "Terraform"
    "Project"     = var.project
    "Environment" = var.tag_name[count.index]
  }
}

resource "aws_s3_bucket_public_access_block" "acl" {
  count  = length(var.bucket_name)
  bucket = aws_s3_bucket.bucket[count.index].id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_object" "files" {
  count        = length(var.bucket_name)
  bucket       = aws_s3_bucket.bucket[count.index].id
  key          = "index.html"
  source       = var.source_html[count.index]
  content_type = "text/html"
}

resource "aws_s3_bucket_website_configuration" "website" {
  count  = length(var.bucket_name)
  bucket = aws_s3_bucket.bucket[count.index].id

  index_document {
    suffix = "index.html"
  }
}

resource "aws_s3_bucket_policy" "policy" {
  count      = length(var.bucket_name)
  bucket     = aws_s3_bucket.bucket[count.index].id
  policy = jsonencode(
    {
      Version = "2012-10-17",
      Statement = [
        {
          Sid       = "PublicReadGetObject",
          Effect    = "Allow",
          Principal = "*",
          Action    = "s3:GetObject",
          Resource  = "arn:aws:s3:::${aws_s3_bucket.bucket[count.index].id}/*"
        }
      ]
    }
  )
}

