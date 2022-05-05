## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_log_group.TaskDF-Log_Group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_ecs_task_definition.ecs_task_definition](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_task_definition) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_container_name"></a> [container\_name](#input\_container\_name) | The name of the Container specified in the Task definition | `string` | n/a | yes |
| <a name="input_container_port"></a> [container\_port](#input\_container\_port) | The port that the container will use to listen to requests | `number` | n/a | yes |
| <a name="input_cpu"></a> [cpu](#input\_cpu) | The CPU value to assign to the container, read AWS documentation for available values | `string` | n/a | yes |
| <a name="input_docker_repo"></a> [docker\_repo](#input\_docker\_repo) | The docker registry URL in which ecs will get the Docker image | `string` | n/a | yes |
| <a name="input_execution_role_arn"></a> [execution\_role\_arn](#input\_execution\_role\_arn) | The IAM ARN role that the ECS task will use to call other AWS services | `string` | n/a | yes |
| <a name="input_memory"></a> [memory](#input\_memory) | The MEMORY value to assign to the container, read AWS documentation to available values | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | The name for Task Definition | `string` | n/a | yes |
| <a name="input_rds_password_ssm_arn"></a> [rds\_password\_ssm\_arn](#input\_rds\_password\_ssm\_arn) | n/a | `string` | n/a | yes |
| <a name="input_rds_username_ssm_arn"></a> [rds\_username\_ssm\_arn](#input\_rds\_username\_ssm\_arn) | n/a | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | AWS Region in which the resources will be deployed | `string` | n/a | yes |
| <a name="input_task_role_arn"></a> [task\_role\_arn](#input\_task\_role\_arn) | The IAM ARN role that the ECS task will use to call other AWS services | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn_task_definition"></a> [arn\_task\_definition](#output\_arn\_task\_definition) | n/a |
| <a name="output_task_definition_family"></a> [task\_definition\_family](#output\_task\_definition\_family) | n/a |
