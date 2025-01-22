resource "aws_security_group" "amp-ec2-sg" {
  name        = var.aws_security_group_name
  vpc_id      = var.vpc_id
  # allow ingress of port SSH
  ingress {
    cidr_blocks = var.vpc_cidr
    from_port   = 22
    to_port     = 22
    protocol    = var.protocol
  } 
  # allow ingress of port HTTPS
  ingress {
    cidr_blocks = var.vpc_cidr
    from_port   = 443
    to_port     = 443
    protocol    = var.protocol
  } 
  # allow ingress of port RDP
  ingress {
    cidr_blocks = var.vpc_cidr 
    from_port   = 3389
    to_port     = 3389
    protocol    = var.protocol
  } 
  # allow ingress of port HTTP
  ingress {
    cidr_blocks = var.vpc_cidr
    from_port   = 80
    to_port     = 80
    protocol    = var.protocol
  } 
tags = {
   Name = var.aws_security_group_name
}
}