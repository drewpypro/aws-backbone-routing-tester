
resource "aws_vpc" "vpc" {
  for_each = toset(var.regions)

  cidr_block = var.vpc_cidr
  tags = {
    Name = "${each.key}-vpc"
  }

}

resource "aws_subnet" "subnet" {
  for_each = aws_vpc.vpc

  vpc_id            = each.value.id
  cidr_block        = var.subnet_cidr
  availability_zone = "${each.key}a"
  tags = {
    Name = "${each.key}-subnet"
  }

}

resource "aws_route_table" "rt" {
  for_each = aws_vpc.vpc

  vpc_id = each.value.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw[each.key].id
  }

  tags = {
    Name = "${each.key}-route-table"
  }

}

resource "aws_route_table_association" "rta" {
  for_each = aws_subnet.subnet

  subnet_id      = each.value.id
  route_table_id = aws_route_table.rt[each.key].id

}
