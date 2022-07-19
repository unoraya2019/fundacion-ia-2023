resource "aws_route_table" "iac" {
  vpc_id = aws_vpc.iac.id
  depends_on = [
    aws_vpc.iac, aws_internet_gateway.iac
  ]

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.iac.id
  }
  tags = {
    Name = "Routing Table iac"
  }
}

# Subnets Association

resource "aws_route_table_association" "wordpress_a" {
  subnet_id      = aws_subnet.wordpress_a.id
  route_table_id = aws_route_table.iac.id
}

resource "aws_route_table_association" "wordpress_b" {
  subnet_id      = aws_subnet.wordpress_b.id
  route_table_id = aws_route_table.iac.id
}

# DB Production

resource "aws_route_table_association" "databases_prod_a" {
  subnet_id      = aws_subnet.databases_prod_a.id
  route_table_id = aws_route_table.iac.id
}

resource "aws_route_table_association" "databases_prod_b" {
  subnet_id      = aws_subnet.databases_prod_b.id
  route_table_id = aws_route_table.iac.id
}
