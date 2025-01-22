
module "prod" {
   source = "../../../modules/ec2"
   config = var.config
   environment = var.environment
   aws_security_group_name = var.aws_security_group_name
   record_ttl = var.record_ttl
   record_type = var.record_type
   vpc_id = var.vpc_id
   vpc_cidr = var.vpc_cidr
   protocol = var.protocol
   key_name = var.key_name
   hosted_zone = var.hosted_zone

}
 
