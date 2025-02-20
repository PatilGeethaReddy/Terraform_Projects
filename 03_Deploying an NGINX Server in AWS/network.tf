locals {
    tags = {
    managedBy = "Terraform"
    Project =  "Vprofile"
    CostCenter = "1234"
  }
  
}

resource "aws_vpc" "main" {
  cidr_block       = "10.0.0.0/16"

  tags = merge(local.tags, {
    Name = "Vprofile"
})
}

resource "aws_subnet" "Vprofile-subnet-public" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.1.0/24"

    tags = merge(local.tags, {
    Name = "Vprofile-subnet-public"
})
}

resource "aws_subnet" "Vprofile-subnet-private" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.2.0/24"
      tags = merge(local.tags, {
    Name = "Vprofile-subnet-private"
})
}

resource "aws_internet_gateway" "Vprofile-gw" {
  vpc_id = aws_vpc.main.id

      tags = merge(local.tags, {
    Name = "Vprofile-IG"
})
}

resource "aws_route_table" "Vprofile-rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.Vprofile-gw.id
  }

      tags = merge(local.tags, {
    Name = "Vprofile-rt"
})
}

resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.Vprofile-subnet-public.id
  route_table_id = aws_route_table.Vprofile-rt.id
}

