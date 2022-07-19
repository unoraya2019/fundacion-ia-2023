resource "aws_route53_zone" "iac" {
  name = var.domain
  vpc {
    vpc_id     = aws_vpc.iac.id
    vpc_region = var.region
  }
  tags = {
    "Name" = "${var.domain}"
  }
}
