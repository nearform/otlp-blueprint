[
  {
    "name": "jaeger-app",
    "image": "${app_image}",
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
        "containerPort": ${frontend_app_port},
        "hostPort": ${frontend_app_port}
      },
      {
        "containerPort": ${grpc_app_port},
        "hostPort": ${grpc_app_port}
      },
      {
        "containerPort": ${grpc_otlp_app_port},
        "hostPort": ${grpc_otlp_app_port}
      },
      {
        "containerPort": ${http_otlp_app_port},
        "hostPort": ${http_otlp_app_port}
      },
      {
        "containerPort": 5778,
        "hostPort": 5778
      },
      {
        "containerPort": 14268,
        "hostPort": 14268
      },
      {
        "containerPort": 14269,
        "hostPort": 14269
      },
      {
        "containerPort": 9411,
        "hostPort": 9411
      },
      {
        "containerPort": 5775,
        "hostPort": 5775
      },
      {
        "containerPort": 6831,
        "hostPort": 6831
      },
      {
        "containerPort": 6832,
        "hostPort": 6832
      }
    ]
  }
]
