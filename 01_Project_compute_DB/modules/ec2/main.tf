//Here we create local variable names serverconfig
locals {
  serverconfig = [
    for srv in var.config : [
      for i in range(1, srv.no_of_instances+1) : {
        instance_name = "${srv.application_name}-${i}"
        instance_type = srv.instance_type
        subnet_id   = srv.subnet_id
        ami = srv.ami_id
        volume_size = srv.volume_size
        volume_type = srv.volume_type
        device_name = srv.device_name
      }
    ]
  ]
}
// We need to Flatten it before using it
locals {
  instances = flatten(local.serverconfig)
}
# ec2 creation
resource "aws_instance" "AMP-instances" {
 for_each = { for server in local.instances : index(local.instances, server) => server }
 subnet_id     ="${element(each.value.subnet_id,each.key)}"
  ami           = each.value.ami         
  key_name      = var.key_name
  vpc_security_group_ids = [aws_security_group.amp-ec2-sg.id]
  instance_type =each.value.instance_type
  ebs_block_device {
  volume_size = each.value.volume_size
  volume_type = each.value.volume_type
  device_name = each.value.device_name 
  } 
  tags = {
    Name = "${var.environment}-${each.value.instance_name}"
    Environment = var.environment
    Function = "${each.value.instance_name}"
      }
}
// hosted zone creation
resource "aws_route53_zone" "Amdocs_HZ" {
 name = var.hosted_zone  
  vpc {
    vpc_id = var.vpc_id
  }
}
// Record Creation
resource "aws_route53_record" "ec2_record" {
zone_id  = aws_route53_zone.Amdocs_HZ.zone_id
for_each = { for server in local.instances : index(local.instances, server) => server }
name    = lookup(aws_instance.AMP-instances[each.key].tags,"Name")                                                    
type    = var.record_type
ttl     = var.record_ttl
records = [aws_instance.AMP-instances[each.key].private_ip] 
}






































































