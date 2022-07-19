# Subnets Public

resource "aws_subnet" "wordpress_b" {
  vpc_id                  = aws_vpc.iac.id
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1b"
  cidr_block              = "10.1.100.0/24"
  lifecycle {
    create_before_destroy = true
  }
  tags = {
    Name = "Wordpress DCA"
  }
}

# Database Production

resource "aws_subnet" "databases_prod_b" {
  vpc_id            = aws_vpc.iac.id
  availability_zone = "us-east-1b"
  cidr_block        = "10.1.40.0/27"
  lifecycle {
    create_before_destroy = true
  }
  tags = {
    Name = "Databases Prod DCA"
  }
}
