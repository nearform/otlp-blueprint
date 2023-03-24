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
    "environment": [
      {
        "name": "PG_HOST",
        "value": "${db_host}"
      },
      {
        "name": "PG_USER",
        "value": "${db_username}"
      },
      {
        "name": "PG_PORT",
        "value": "${db_port}"
      },
      {
        "name": "PG_DB",
        "value": "${db_name}"
      },
      {
        "name": "SECRETS_PG_INFO",
        "value": "${database_secret_arn}"
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
