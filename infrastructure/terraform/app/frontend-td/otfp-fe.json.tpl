[
  {
    "name": "otfp-fe-app",
    "image": "${app_image}",
    "cpu": ${fargate_cpu},
    "memory": ${fargate_memory},
    "networkMode": "awsvpc",
    "logConfiguration": {
        "logDriver": "awslogs",
        "options": {
          "awslogs-group": "${deployment_env}_${otlp_log_group_name}",
          "awslogs-region": "${aws_region}",
          "awslogs-stream-prefix": "${deployment_env}_otlp"
        }
    },
    "portMappings": [
      {
        "containerPort": ${app_port},
        "hostPort": ${app_port}
      }
    ]
  }
]