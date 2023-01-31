[
  {
    "name": "jaeger-app",
    "image": "${app_image}",
    "command": ["--collector.otlp.enabled=true", "--collector.otlp.grpc.host-port=0.0.0.0:4317"],
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
        "containerPort": ${jaeger_app_port},
        "hostPort": ${jaeger_app_port}
      },
      {
        "containerPort": ${http_otlp_app_port},
        "hostPort": ${http_otlp_app_port}
      }
    ]
  }
]
