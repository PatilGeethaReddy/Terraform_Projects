resource "aws_vpc" "landing-zone-vpc" {
   cidr_block = var.vpc_cidr
   enable_dns_hostnames = true
 tags = {
   Name = var.vpc_name
 }
}
