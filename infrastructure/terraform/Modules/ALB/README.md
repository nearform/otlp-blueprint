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
| [aws_alb.alb](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/alb) | resource |
| [aws_alb_listener.http_listener](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/alb_listener) | resource |
| [aws_alb_listener.https_listener](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/alb_listener) | resource |
| [aws_alb_target_group.target_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/alb_target_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_create_alb"></a> [create\_alb](#input\_create\_alb) | Set to true to create an ALB | `bool` | `false` | no |
| <a name="input_create_target_group"></a> [create\_target\_group](#input\_create\_target\_group) | Set to true to create a Target Group | `bool` | `false` | no |
| <a name="input_enable_https"></a> [enable\_https](#input\_enable\_https) | Set to true to create a HTTPS listener | `bool` | `false` | no |
| <a name="input_health_check_path"></a> [health\_check\_path](#input\_health\_check\_path) | The path in which the ALB will send health checks | `string` | `""` | no |
| <a name="input_health_check_port"></a> [health\_check\_port](#input\_health\_check\_port) | The port to which the ALB will send health checks | `number` | `80` | no |
| <a name="input_name"></a> [name](#input\_name) | A name for the target group or ALB | `string` | n/a | yes |
| <a name="input_port"></a> [port](#input\_port) | The port that the targer group will use | `number` | `80` | no |
| <a name="input_protocol"></a> [protocol](#input\_protocol) | The protocol that the target group will use | `string` | `""` | no |
| <a name="input_security_group"></a> [security\_group](#input\_security\_group) | Security group ID for the ALB | `string` | `""` | no |
| <a name="input_subnets"></a> [subnets](#input\_subnets) | Subnets IDs for ALB | `list(any)` | `[]` | no |
| <a name="input_target_group"></a> [target\_group](#input\_target\_group) | The ARN of the created target group | `string` | `""` | no |
| <a name="input_target_group_green"></a> [target\_group\_green](#input\_target\_group\_green) | The ANR of the created target group | `string` | `""` | no |
| <a name="input_tg_type"></a> [tg\_type](#input\_tg\_type) | Target Group Type (instance, IP, lambda) | `string` | `""` | no |
| <a name="input_vpc"></a> [vpc](#input\_vpc) | VPC ID for the Target Group | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn_alb"></a> [arn\_alb](#output\_arn\_alb) | n/a |
| <a name="output_arn_listener"></a> [arn\_listener](#output\_arn\_listener) | n/a |
| <a name="output_arn_tg"></a> [arn\_tg](#output\_arn\_tg) | n/a |
| <a name="output_dns_alb"></a> [dns\_alb](#output\_dns\_alb) | n/a |
| <a name="output_tg_name"></a> [tg\_name](#output\_tg\_name) | n/a |
