resource "aws_subnet" "LZ-Subnets" {
  count = length(var.availability_zone)
    vpc_id = aws_vpc.landing-zone-vpc.id
    cidr_block = var.subnet-cidr[count.index]
    availability_zone = var.availability_zone[count.index]
    tags = {
      Name = var.subnet-names[count.index]
      }
}