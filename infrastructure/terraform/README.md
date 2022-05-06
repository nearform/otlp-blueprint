## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 4.3 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 4.3 |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_alb_server"></a> [alb\_server](#module\_alb\_server) | ./Modules/ALB | n/a |
| <a name="module_codedeploy_role"></a> [codedeploy\_role](#module\_codedeploy\_role) | ./Modules/IAM | n/a |
| <a name="module_codedeploy_server"></a> [codedeploy\_server](#module\_codedeploy\_server) | ./Modules/CodeDeploy | n/a |
| <a name="module_devops_role"></a> [devops\_role](#module\_devops\_role) | ./Modules/IAM | n/a |
| <a name="module_ecr_server"></a> [ecr\_server](#module\_ecr\_server) | ./Modules/ECR | n/a |
| <a name="module_ecs_autoscaling_server"></a> [ecs\_autoscaling\_server](#module\_ecs\_autoscaling\_server) | ./Modules/ECS/Autoscaling | n/a |
| <a name="module_ecs_cluster"></a> [ecs\_cluster](#module\_ecs\_cluster) | ./Modules/ECS/Cluster | n/a |
| <a name="module_ecs_role"></a> [ecs\_role](#module\_ecs\_role) | ./Modules/IAM | n/a |
| <a name="module_ecs_service_server"></a> [ecs\_service\_server](#module\_ecs\_service\_server) | ./Modules/ECS/Service | n/a |
| <a name="module_ecs_taks_definition_server"></a> [ecs\_taks\_definition\_server](#module\_ecs\_taks\_definition\_server) | ./Modules/ECS/TaskDefinition | n/a |
| <a name="module_networking"></a> [networking](#module\_networking) | ./Modules/Networking | n/a |
| <a name="module_policy_devops_role"></a> [policy\_devops\_role](#module\_policy\_devops\_role) | ./Modules/IAM | n/a |
| <a name="module_rds"></a> [rds](#module\_rds) | ./Modules/RDS | n/a |
| <a name="module_s3_assets"></a> [s3\_assets](#module\_s3\_assets) | ./Modules/S3 | n/a |
| <a name="module_security_group_alb_server"></a> [security\_group\_alb\_server](#module\_security\_group\_alb\_server) | ./Modules/SecurityGroup | n/a |
| <a name="module_security_group_ecs_task_server"></a> [security\_group\_ecs\_task\_server](#module\_security\_group\_ecs\_task\_server) | ./Modules/SecurityGroup | n/a |
| <a name="module_security_group_rds"></a> [security\_group\_rds](#module\_security\_group\_rds) | ./Modules/SecurityGroup | n/a |
| <a name="module_target_group_server_blue"></a> [target\_group\_server\_blue](#module\_target\_group\_server\_blue) | ./Modules/ALB | n/a |
| <a name="module_target_group_server_green"></a> [target\_group\_server\_green](#module\_target\_group\_server\_green) | ./Modules/ALB | n/a |

## Resources

| Name | Type |
|------|------|
| [random_id.RANDOM_ID](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) | resource |
| [aws_caller_identity.id_current_account](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | The AWS Region in which you want to deploy the resources | `string` | n/a | yes |
| <a name="input_buildspec_path"></a> [buildspec\_path](#input\_buildspec\_path) | The location of the buildspec file. | `string` | `"./infrastructure/Templates/buildspec.yml"` | no |
| <a name="input_container_name"></a> [container\_name](#input\_container\_name) | The name of the container of each ECS service | `map(string)` | <pre>{<br>  "server": "Container-server"<br>}</pre> | no |
| <a name="input_environment_name"></a> [environment\_name](#input\_environment\_name) | The name of your environment | `string` | n/a | yes |
| <a name="input_folder_path_server"></a> [folder\_path\_server](#input\_folder\_path\_server) | The location of the server files | `string` | `"./pkg-svcs/backend/."` | no |
| <a name="input_iam_role_name"></a> [iam\_role\_name](#input\_iam\_role\_name) | The name of the IAM Role for each service | `map(string)` | <pre>{<br>  "codedeploy": "CodeDeploy-Role",<br>  "devops": "DevOps-Role",<br>  "ecs": "ECS-task-execution-Role",<br>  "ecs_task_role": "ECS-task-Role"<br>}</pre> | no |
| <a name="input_port_app_server"></a> [port\_app\_server](#input\_port\_app\_server) | The port used by your server application | `number` | `3000` | no |
| <a name="input_port_rds"></a> [port\_rds](#input\_port\_rds) | n/a | `string` | `"5432"` | no |
| <a name="input_rds_identifier"></a> [rds\_identifier](#input\_rds\_identifier) | n/a | `string` | `"some-name"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_alb_endpoint"></a> [alb\_endpoint](#output\_alb\_endpoint) | ALB endpoint |
| <a name="output_application_name"></a> [application\_name](#output\_application\_name) | n/a |
| <a name="output_aws_s3_bucket_site_arn"></a> [aws\_s3\_bucket\_site\_arn](#output\_aws\_s3\_bucket\_site\_arn) | n/a |
| <a name="output_aws_s3_bucket_site_id"></a> [aws\_s3\_bucket\_site\_id](#output\_aws\_s3\_bucket\_site\_id) | n/a |
| <a name="output_aws_s3_bucket_website_domain"></a> [aws\_s3\_bucket\_website\_domain](#output\_aws\_s3\_bucket\_website\_domain) | n/a |
| <a name="output_deployment_group_name"></a> [deployment\_group\_name](#output\_deployment\_group\_name) | n/a |
| <a name="output_ecr_repository_url"></a> [ecr\_repository\_url](#output\_ecr\_repository\_url) | URL of the ECR repository for the server image |
| <a name="output_ecs_role"></a> [ecs\_role](#output\_ecs\_role) | n/a |
| <a name="output_ecs_task_role"></a> [ecs\_task\_role](#output\_ecs\_task\_role) | n/a |
| <a name="output_master_rds_username"></a> [master\_rds\_username](#output\_master\_rds\_username) | n/a |
| <a name="output_rds_db_instance_address"></a> [rds\_db\_instance\_address](#output\_rds\_db\_instance\_address) | n/a |
| <a name="output_rds_db_instance_arn"></a> [rds\_db\_instance\_arn](#output\_rds\_db\_instance\_arn) | n/a |
| <a name="output_rds_identifier"></a> [rds\_identifier](#output\_rds\_identifier) | n/a |
| <a name="output_rds_password_ssm_arn"></a> [rds\_password\_ssm\_arn](#output\_rds\_password\_ssm\_arn) | n/a |
| <a name="output_rds_username_ssm_arn"></a> [rds\_username\_ssm\_arn](#output\_rds\_username\_ssm\_arn) | n/a |
| <a name="output_task_definition_family"></a> [task\_definition\_family](#output\_task\_definition\_family) | n/a |
