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
| [aws_codedeploy_app.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/codedeploy_app) | resource |
| [aws_codedeploy_deployment_group.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/codedeploy_deployment_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_alb_listener"></a> [alb\_listener](#input\_alb\_listener) | The ARN of the ALB listener for production | `string` | n/a | yes |
| <a name="input_codedeploy_role"></a> [codedeploy\_role](#input\_codedeploy\_role) | The role to be assumed by CodeDeploy | `string` | n/a | yes |
| <a name="input_ecs_cluster"></a> [ecs\_cluster](#input\_ecs\_cluster) | The name of the ECS cluster where to deploy | `string` | n/a | yes |
| <a name="input_ecs_service"></a> [ecs\_service](#input\_ecs\_service) | The name of the ECS service to deploy | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | The name of the CodeDeploy application | `string` | n/a | yes |
| <a name="input_tg_blue"></a> [tg\_blue](#input\_tg\_blue) | The Target group name for the Blue part | `string` | n/a | yes |
| <a name="input_tg_green"></a> [tg\_green](#input\_tg\_green) | The Target group name for the Green part | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_application_arn"></a> [application\_arn](#output\_application\_arn) | n/a |
| <a name="output_application_name"></a> [application\_name](#output\_application\_name) | n/a |
| <a name="output_deployment_group_arn"></a> [deployment\_group\_arn](#output\_deployment\_group\_arn) | n/a |
| <a name="output_deployment_group_name"></a> [deployment\_group\_name](#output\_deployment\_group\_name) | n/a |
