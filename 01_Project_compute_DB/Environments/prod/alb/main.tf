// creating multiple Target groups by using for_each with different configuration
resource  "aws_lb_target_group" "AMP-target-group" {
  for_each = var.tg-config
  target_type = each.value.target_type
  name        = each.value.tg-name   
  port        = each.value.port 
  protocol    = each.value.protocol
  vpc_id      = var.vpc_id
  protocol_version = each.value.protocol_version
health_check {
interval            = lookup(each.value["health_check"],"interval")
path                = lookup(each.value["health_check"],"path")
protocol            = lookup(each.value["health_check"],"protocol")
timeout             = lookup(each.value["health_check"],"timeout")
healthy_threshold   = lookup(each.value["health_check"],"healthy_threshold")
unhealthy_threshold = lookup(each.value["health_check"],"unhealthy_threshold")
}
stickiness { 
    type = each.value.stickiness_type
    enabled = each.value.stickiness
  }
}
//Grabbbing existing instance id’s by using Ec2 tag names
data "aws_instances" "wl-op" {
  count = var.wl-op.counts
   filter {
    name   = "tag:Name"
    values =[var.wl-op.ec2-name]
  }
  instance_state_names = ["running"]
}
//Grabbbing existing instance id’s by using Ec2 tag names
data "aws_instances" "wl-Admin" {
  count = var.wl-Admin.counts
   filter {
    name   = "tag:Name"
    values =[var.wl-Admin.ec2-name]
  }
  instance_state_names = ["running"]
}
//Grabbbing existing instance id’s by using Ec2 tag names
data "aws_instances" "wl-Client" {
  count = var.wl-Client.counts
   filter {
    name   = "tag:Name"
    values =[var.wl-Client.ec2-name]
  }
  instance_state_names = ["running"]
}
//Grabbbing existing instance id’s by using Ec2 tag names
data "aws_instances" "wl-re" {
  count = var.wl-RE.counts
   filter {
    name   = "tag:Name"
    values =[var.wl-RE.ec2-name]
  }
  instance_state_names = ["running"]
}
//Grabbbing existing instance id’s by using Ec2 tag names
data "aws_instances" "wl-pm" {
  count = var.wl-RE.counts
   filter {
    name   = "tag:Name"
    values =[var.wl-PM.ec2-name]
  }
  instance_state_names = ["running"]
}
//Attaching wl-op instances to wl-op-target group
resource "aws_alb_target_group_attachment" "WL-OP-attachment" {
  count = var.wl-op.counts
  target_group_arn = aws_lb_target_group.AMP-target-group["WL-OP-TG"].arn
  target_id = element(data.aws_instances.wl-op[count.index].ids,count.index)
  port             = "9902" 
}
//Attaching wl-Admin instances to wl-Admin-target group
resource "aws_alb_target_group_attachment" "WL-Admin-attachment" {
  count = var.wl-Admin.counts
  target_group_arn = aws_lb_target_group.AMP-target-group["WL-Admin-TG"].arn
  target_id = element(data.aws_instances.wl-Admin[count.index].ids,count.index)
  port             = "9901"
}
//Attaching wl-Client instances to wl-Client-target group
resource "aws_alb_target_group_attachment" "WL-Client-attachment" {
  count = var.wl-Client.counts
  target_group_arn = aws_lb_target_group.AMP-target-group["WL-Client-TG"].arn
  target_id = element(data.aws_instances.wl-Client[count.index].ids,count.index)
  port             = "9907"
}
//Attaching wl-Client instances to wl-RE-target group
resource "aws_alb_target_group_attachment" "WL-RE-attachment" {
  count = var.wl-RE.counts
  target_group_arn = aws_lb_target_group.AMP-target-group["WL-RE-TG"].arn
  target_id = element(data.aws_instances.wl-re[count.index].ids,count.index)
  port             = "9904"
}
//Attaching wl-Client instances to wl-PM-target group
resource "aws_alb_target_group_attachment" "WL-PM-attachment" {
  count = var.wl-PM.counts
  target_group_arn = aws_lb_target_group.AMP-target-group["WL-PM-TG"].arn
  target_id = element(data.aws_instances.wl-pm[count.index].ids,count.index)
  port             = "9903"
}
//Creating Application Load Balancer
resource "aws_lb" "AMP-AWS-ALB" {
  name     = var.alb_name
  internal = var.alb_internal
  security_groups = [var.sg-id]   
  subnets = var.subnets
  ip_address_type    = var.ip_address_type
  load_balancer_type = var.load_balancer_type
  tags = {
     Name = var.alb_name
   }
}
//Creating Listeners
resource "aws_lb_listener" "AMP-AWS-ALB-listener" {
for_each = var.tg-config 
load_balancer_arn = aws_lb.AMP-AWS-ALB.id
port              = each.value.port
protocol          = each.value.protocol
default_action {
    type = "forward"
    target_group_arn =aws_lb_target_group.AMP-target-group[each.key].arn         
  }
}
//DNS record creation for ALB
resource "aws_route53_record" "alb_record" {
zone_id  = var.zone_id
name    = var.record_name                                                 
type    = var.record_type
ttl     = var.record_ttl
records = [aws_lb.AMP-AWS-ALB.dns_name] 
}