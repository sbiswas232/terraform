# VPC created by console & Import by Terraform
resource "aws_vpc" "vpc" {
  assign_generated_ipv6_cidr_block     = false
  cidr_block                           = "172.16.0.0/16"
  enable_dns_hostnames                 = false
  enable_dns_support                   = true
  enable_network_address_usage_metrics = false
  instance_tenancy                     = "default"
  ipv4_ipam_pool_id                    = null
  ipv4_netmask_length                  = null
  tags = {
    Company     = "Terraform"
    Environment = "Dev"
    Name        = "vpc30may"
  }
  tags_all = {
    Company     = "Terraform"
    Environment = "Dev"
    Name        = "vpc30may"
  }
}

# Public Subnet created by console & Import by Terraform
resource "aws_subnet" "public_subnet" {
  vpc_id                                         = aws_vpc.vpc.id
  assign_ipv6_address_on_creation                = false
  availability_zone                              = "ap-southeast-1a"
  cidr_block                                     = "172.16.1.0/24"
  customer_owned_ipv4_pool                       = null
  enable_dns64                                   = false
  enable_resource_name_dns_a_record_on_launch    = false
  enable_resource_name_dns_aaaa_record_on_launch = false
  map_public_ip_on_launch                        = true
  outpost_arn                                    = null
  private_dns_hostname_type_on_launch            = "ip-name"
  tags = {
    Company     = "Terraform"
    Environment = "Dev"
    Name        = "public-subnet30may"
  }
  tags_all = {
    Company     = "Terraform"
    Environment = "Dev"
    Name        = "public-subnet30may"
  }
}

# Private Subnet created by console & Imort by Terraform
resource "aws_subnet" "private_subnet" {
  vpc_id                                         = aws_vpc.vpc.id
  assign_ipv6_address_on_creation                = false
  availability_zone                              = "ap-southeast-1b"
  cidr_block                                     = "172.16.2.0/24"
  customer_owned_ipv4_pool                       = null
  enable_dns64                                   = false
  enable_resource_name_dns_a_record_on_launch    = false
  enable_resource_name_dns_aaaa_record_on_launch = false
  map_public_ip_on_launch                        = false
  outpost_arn                                    = null
  private_dns_hostname_type_on_launch            = "ip-name"
  tags = {
    Company     = "Terraform"
    Environment = "Dev"
    Name        = "private-subnet30may"
  }
  tags_all = {
    Company     = "Terraform"
    Environment = "Dev"
    Name        = "private-subnet30may"
  }
}
