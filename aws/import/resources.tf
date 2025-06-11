# # __generated__ by Terraform
# # Please review these resources and move them into your main configuration files.

# # __generated__ by Terraform
# resource "aws_subnet" "private_subnet" {
#   assign_ipv6_address_on_creation                = false
#   availability_zone                              = "ap-southeast-1b"
#   availability_zone_id                           = "apse1-az2"
#   cidr_block                                     = "172.16.2.0/24"
#   customer_owned_ipv4_pool                       = null
#   enable_dns64                                   = false
#   enable_lni_at_device_index                     = 0
#   enable_resource_name_dns_a_record_on_launch    = false
#   enable_resource_name_dns_aaaa_record_on_launch = false
#   ipv6_cidr_block                                = null
#   ipv6_native                                    = false
#   map_customer_owned_ip_on_launch                = false
#   map_public_ip_on_launch                        = false
#   outpost_arn                                    = null
#   private_dns_hostname_type_on_launch            = "ip-name"
#   tags = {
#     Company     = "Terraform"
#     Environment = "Dev"
#     Name        = "private-subnet30may"
#   }
#   tags_all = {
#     Company     = "Terraform"
#     Environment = "Dev"
#     Name        = "private-subnet30may"
#   }
#   vpc_id = "vpc-053b209618826d14e"
# }

# # __generated__ by Terraform
# resource "aws_subnet" "public_subnet" {
#   assign_ipv6_address_on_creation                = false
#   availability_zone                              = "ap-southeast-1a"
#   availability_zone_id                           = "apse1-az1"
#   cidr_block                                     = "172.16.1.0/24"
#   customer_owned_ipv4_pool                       = null
#   enable_dns64                                   = false
#   enable_lni_at_device_index                     = 0
#   enable_resource_name_dns_a_record_on_launch    = false
#   enable_resource_name_dns_aaaa_record_on_launch = false
#   ipv6_cidr_block                                = null
#   ipv6_native                                    = false
#   map_customer_owned_ip_on_launch                = false
#   map_public_ip_on_launch                        = true
#   outpost_arn                                    = null
#   private_dns_hostname_type_on_launch            = "ip-name"
#   tags = {
#     Company     = "Terraform"
#     Environment = "Dev"
#     Name        = "public-subnet30may"
#   }
#   tags_all = {
#     Company     = "Terraform"
#     Environment = "Dev"
#     Name        = "public-subnet30may"
#   }
#   vpc_id = "vpc-053b209618826d14e"
# }

# # __generated__ by Terraform
# resource "aws_vpc" "vpc" {
#   assign_generated_ipv6_cidr_block     = false
#   cidr_block                           = "172.16.0.0/16"
#   enable_dns_hostnames                 = false
#   enable_dns_support                   = true
#   enable_network_address_usage_metrics = false
#   instance_tenancy                     = "default"
#   ipv4_ipam_pool_id                    = null
#   ipv4_netmask_length                  = null
#   ipv6_cidr_block                      = null
#   ipv6_cidr_block_network_border_group = null
#   ipv6_ipam_pool_id                    = null
#   ipv6_netmask_length                  = 0
#   tags = {
#     Company     = "Terraform"
#     Environment = "Dev"
#     Name        = "vpc30may"
#   }
#   tags_all = {
#     Company     = "Terraform"
#     Environment = "Dev"
#     Name        = "vpc30may"
#   }
# }
