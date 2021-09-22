[
  {
    "name": "${service_name}",
    "image": "${service_image}",
    "cpu": ${service_cpu},
    "memory": ${service_memory},
    "networkMode": "awsvpc",
    "logConfiguration": {
        "logDriver": "awslogs",
        "options": {
          "awslogs-group": "/ecs/${service_name}-log-group",
          "awslogs-region": "${service_region}",
          "awslogs-stream-prefix": "ecs"
        }
    },
    "portMappings": [
      {
        "containerPort": ${service_port},
        "hostPort": ${service_port}
      }
    ]
  }
]
