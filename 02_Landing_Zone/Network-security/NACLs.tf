resource "aws_network_acl" "LZ-NACL" {
  vpc_id = var.vpc_id
  egress {
    protocol   = var.protocol
    rule_no    = 200
    action     = "allow"
    cidr_block = var.vpc_cidr
    from_port  = 443
    to_port    = 443
  }
  ingress {
    protocol   = var.protocol
    rule_no    = 100
    action     = "allow"
    cidr_block = var.vpc_cidr
    from_port  = 80
    to_port    = 80
  }
  tags = {
    Name = var.NACL_name
  }
}