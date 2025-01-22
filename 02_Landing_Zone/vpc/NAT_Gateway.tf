resource "aws_eip" "eip_Nat" {
  count = length(var.availability_zone)
}
resource "aws_nat_gateway" "LZ-nat_gw" {
   count = length(var.availability_zone)
  allocation_id = aws_eip.eip_Nat[count.index].id 
  subnet_id = aws_subnet.LZ-Subnets[count.index].id
  tags = {
    Name = var.nat_gw_names[count.index] 
  }
}
