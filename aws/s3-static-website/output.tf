output "s3_url" {
  value = aws_s3_bucket_website_configuration.website[*].website_endpoint
}