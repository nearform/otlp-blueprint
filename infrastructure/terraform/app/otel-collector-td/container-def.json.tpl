[
  {
    "name": "otel-collector-app",
    "image": "${app_image}",
    "command": ["--config=/etc/otel-collector-config.yaml"],
    "cpu": ${fargate_cpu},
    "memory": ${fargate_memory},
    "networkMode": "awsvpc",
    "logConfiguration": {
        "logDriver": "awslogs",
        "options": {
          "awslogs-group": "${otlp_log_group_name}",
          "awslogs-region": "${aws_region}",
          "awslogs-stream-prefix": "otlp"
        }
    },
    "portMappings": [
      {
        "containerPort": ${app_port},
        "hostPort": ${app_port}
      },
      {
        "containerPort": 13133,
        "hostPort": 13133
      }
    ]
  }
]
