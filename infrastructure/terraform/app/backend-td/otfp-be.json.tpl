[
  {
    "name": "otfp-be-app",
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
    "secrets": [
      {
        "name": "DB_PASSWORD",
        "valueFrom": "${database_secret_arn}"
      },
      {
        "name": "PG_HOST",
        "valueFrom": "${db_host}"
      },
      {
        "name": "PG_USER",
        "valueFrom": "${db_username}"
      },
      {
        "name": "PG_PORT",
        "valueFrom": "${db_port}"
      },
      {
        "name": "PG_DB",
        "valueFrom": "${db_port}"
      }
    ],
    "portMappings": [
      {
        "containerPort": ${app_port},
        "hostPort": ${app_port}
      }
    ]
  }
]