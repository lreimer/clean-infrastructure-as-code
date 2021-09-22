resource "aws_ecs_cluster" "main" {
  name = "${var.service_name}-ecs-cluster"

  tags = merge(var.common_tags, {
    Name = "${var.service_name}-ecs-cluster"
  })
}

data "template_file" "service_template" {
  template = file("./templates/ecs_service.json.tpl")

  vars = {
    service_name   = var.service_name
    service_image  = var.service_image
    service_port   = var.service_port
    service_cpu    = var.service_cpu
    service_memory = var.service_memory
    service_region = data.aws_availability_zones.available.id
  }
}

resource "aws_ecs_task_definition" "service" {
  family                   = "${var.service_name}-ecs-task"
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.service_cpu
  memory                   = var.service_memory
  container_definitions    = data.template_file.service_template.rendered
}

resource "aws_ecs_service" "main" {
  name            = "${var.service_name}-ecs-service"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.service.arn
  desired_count   = var.service_count
  launch_type     = "FARGATE"

  network_configuration {
    security_groups  = [aws_security_group.ecs_tasks.id]
    subnets          = var.public_subnet_ids
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = aws_alb_target_group.service.id
    container_name   = var.service_name
    container_port   = var.service_port
  }

  depends_on = [aws_alb_listener.front_end, aws_iam_role_policy_attachment.ecs_task_execution_role]
}
