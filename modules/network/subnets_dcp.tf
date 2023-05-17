# Subnets wordpress

resource "aws_subnet" "wordpress_a" {
  vpc_id                  = aws_vpc.iac.id
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1a"
  cidr_block              = "10.2.1.0/24"
  lifecycle {
    create_before_destroy = true
  }
  tags = {
    Name = "Wordpress DCP"
  }
}

# Database Production

resource "aws_subnet" "databases_prod_a" {
  vpc_id            = aws_vpc.iac.id
  availability_zone = "us-east-1a"
  cidr_block        = "10.2.4.0/27"
  lifecycle {
    create_before_destroy = true
  }
  tags = {
    Name = "Databases Prod DCP"
  }
}