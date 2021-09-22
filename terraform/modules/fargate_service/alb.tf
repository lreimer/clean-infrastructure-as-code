resource "aws_alb" "main" {
  name            = "${var.service_name}-load-balancer"
  subnets         = var.public_subnet_ids
  security_groups = [aws_security_group.lb.id]
}

resource "aws_alb_target_group" "service" {
  name        = "${var.service_name}-target-group"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "ip"

  health_check {
    healthy_threshold   = "2"
    interval            = "30"
    protocol            = "HTTP"
    matcher             = "200"
    timeout             = "5"
    path                = var.service_health_check_path
    unhealthy_threshold = "3"
  }
}

# Redirect all traffic from the ALB to the target group
resource "aws_alb_listener" "front_end" {
  load_balancer_arn = aws_alb.main.id
  port              = var.service_port
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_alb_target_group.service.id
    type             = "forward"
  }
}
