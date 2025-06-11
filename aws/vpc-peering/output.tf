output "dev_public_ip" {
  value = aws_instance.dev_public.public_ip
}

output "test_public_ip" {
  value = aws_instance.test_public.public_ip
}

output "dev_instance_url" {
  value = "http://${aws_instance.dev_public.public_ip}"
}