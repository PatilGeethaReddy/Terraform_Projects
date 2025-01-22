resource "aws_internet_gateway" "LZ-Internet-gateway" {
    vpc_id = aws_vpc.landing-zone-vpc.id
    tags = {
      Name = var.internet_gateway_name
    }  
}