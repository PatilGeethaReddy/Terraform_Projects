resource "aws_security_group" "amp-rds-sg" {
  name        = var.aws_security_group_name
  vpc_id      = var.vpc_id
  # allow ingress of port Oracle RDS
  ingress {
    cidr_blocks = var.vpc_cidr
    from_port   = var.port
    to_port     = var.port
    protocol    = var.protocol
  } 
tags = {
   Name = var.aws_security_group_name
}
}