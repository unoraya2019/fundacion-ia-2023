# Contains the code that provisions the resources in the cloud.

# Load Balancer AWS

resource "aws_lb" "iac" {
  name               = "alb-${var.stage}-${var.group}-${var.project}"
  load_balancer_type = "application"
  security_groups    = [var.security_groups]
  subnets            = var.subnets

  enable_deletion_protection = var.enable_deletion_protection
  tags = {
    "Name" = "alb-${var.stage}-${var.group}-${var.project}"
  }
}

# Listener HTTP
resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.iac.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.iac.arn
  }
}
# Listener HTTPS

resource "aws_lb_listener" "https" {
  load_balancer_arn = aws_lb.iac.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = var.certificate_arn
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.iac.arn
  }
}
