# Contains the code that provisions the resources in the cloud.

# Task Definition
resource "aws_ecs_task_definition" "iac" {
  family                   = "${var.microservice}-${var.stage}-${var.group}-${var.project}"
  execution_role_arn       = aws_iam_role.ecsTaskExecutionRole.arn
  task_role_arn            = aws_iam_role.ecsTaskExecutionRole.arn
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.cpu
  memory                   = var.memory
  container_definitions = templatefile("templates/${var.microservice}.json", {
    docker_name       = "${var.microservice}-${var.stage}-${var.group}-${var.project}"
    docker_cpu        = var.cpu
    docker_memory     = var.memory
    docker_logs_group = "/ecs/cluster/${var.stage}/${var.group}/${var.project}"
    #docker_image      = "${var.account}.dkr.ecr.${var.region}.amazonaws.com/fundacionbolivar:latest"
    docker_image      = "${aws_ecr_repository.iac.repository_url}"
    environment = [
      { "name" : "WORDPRESS_DB_HOST", "value" : "${var.db_host}" },
      { "name" : "WORDPRESS_DB_PASSWORD", "value" : "${var.db_password}" },
      { "name" : "WORDPRESS_DB_NAME", "value" : "${var.db_name}" },
      { "name" : "WORDPRESS_DB_USER", "value" : "${var.db_username}" },
      { "name" : "WORDPRESS_SITE_URL", "value" : "${var.site_url}" },
      { "name" : "WORDPRESS_TABLE_PREFIX", "value" : "fdsw_" }
    ]
  })
  lifecycle {
    create_before_destroy = true
  }
  
}

# Service
resource "aws_ecs_service" "iac" {
  name                   = "${var.microservice}-${var.stage}-${var.group}-${var.project}"
  cluster                = aws_ecs_cluster.iac.arn
  task_definition        = aws_ecs_task_definition.iac.arn
  desired_count          = 1
  launch_type            = "FARGATE"
  enable_execute_command = true
  network_configuration {
    security_groups  = var.security_group_microservice
    subnets          = var.subnets
    assign_public_ip = true
  }
  load_balancer {
    target_group_arn = aws_lb_target_group.iac.arn
    container_name   = "${var.microservice}-${var.stage}-${var.group}-${var.project}"
    container_port   = var.container_port
  }
  lifecycle {
    ignore_changes        = [desired_count]
    create_before_destroy = true
  }
}

# Listener Rule

resource "aws_lb_listener_rule" "iac_http" {
  listener_arn = aws_lb_listener.http.arn
  condition {
    host_header {
      values = ["${var.domain_app}"]
    }
  }
  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.iac.arn
  }
  depends_on = [
    aws_lb_target_group.iac
  ]
}

# Target Group 
resource "aws_lb_target_group" "iac" {
  name                 = "${replace(var.microservice, "_", "-")}-${var.stage}-${var.group}"
  target_type          = "ip"
  port                 = var.container_port
  protocol             = "HTTP"
  vpc_id               = var.vpc_id
  deregistration_delay = var.deregistration_delay

  health_check {
    healthy_threshold   = "10"
    interval            = "60"
    protocol            = "HTTP"
    matcher             = "404"
    timeout             = "10"
    path                = "/404"
    unhealthy_threshold = "3"
  }

  lifecycle {
    create_before_destroy = true
  }
}

# AutoScaling

resource "aws_appautoscaling_target" "iac" {
  max_capacity       = 10
  min_capacity       = 1
  resource_id        = "service/cluster-${var.stage}-${var.group}-${var.project}/${var.microservice}-${var.stage}-${var.group}-${var.project}"
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = "ecs"
  depends_on = [
    aws_ecs_service.iac
  ]
  #role_arn           = aws_iam_role.ecs-autoscale-role.arn
}

# CPU
resource "aws_appautoscaling_policy" "ecs_cpu" {
  name               = "Application-scaling--cpu"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.iac.resource_id
  scalable_dimension = aws_appautoscaling_target.iac.scalable_dimension
  service_namespace  = aws_appautoscaling_target.iac.service_namespace

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageCPUUtilization"
    }
    target_value       = var.target_value
    scale_in_cooldown  = 300
    scale_out_cooldown = 300

  }
  depends_on = [aws_appautoscaling_target.iac]
}

# Memory
resource "aws_appautoscaling_policy" "ecs_memory" {
  name               = "Application-scaling--memory"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.iac.resource_id
  scalable_dimension = aws_appautoscaling_target.iac.scalable_dimension
  service_namespace  = aws_appautoscaling_target.iac.service_namespace

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageMemoryUtilization"
    }
    target_value       = var.target_value
    scale_in_cooldown  = 300
    scale_out_cooldown = 300

  }
  depends_on = [aws_appautoscaling_target.iac]
}
