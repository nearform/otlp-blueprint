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
| [aws_ecs_service.ecs_service](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_service) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_arn_security_group"></a> [arn\_security\_group](#input\_arn\_security\_group) | ARN of the security group for the tasks | `string` | n/a | yes |
| <a name="input_arn_target_group"></a> [arn\_target\_group](#input\_arn\_target\_group) | The ARN of the AWS Target Group to put the ECS task | `string` | n/a | yes |
| <a name="input_arn_task_definition"></a> [arn\_task\_definition](#input\_arn\_task\_definition) | The ARN of the Task Definition to use to deploy the tasks | `string` | n/a | yes |
| <a name="input_container_name"></a> [container\_name](#input\_container\_name) | The name of the container | `string` | n/a | yes |
| <a name="input_container_port"></a> [container\_port](#input\_container\_port) | The port that the container will listen request | `string` | n/a | yes |
| <a name="input_desired_tasks"></a> [desired\_tasks](#input\_desired\_tasks) | The minumum number of tasks to run in the service | `string` | n/a | yes |
| <a name="input_ecs_cluster_id"></a> [ecs\_cluster\_id](#input\_ecs\_cluster\_id) | The ECS cluster ID in which the resources will be created | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | The name for the ecs service | `string` | n/a | yes |
| <a name="input_subnets_id"></a> [subnets\_id](#input\_subnets\_id) | Subnet ID in which ecs will deploy the tasks | `list(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ecs_service_name"></a> [ecs\_service\_name](#output\_ecs\_service\_name) | n/a |
