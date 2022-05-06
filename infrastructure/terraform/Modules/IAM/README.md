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
| [aws_iam_policy.policy_for_ecs_task_execution_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.policy_for_ecs_task_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.policy_for_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.codedeploy_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.devops_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.ecs_task_execution_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.ecs_task_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.attachment-ssm](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.attachment2](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.codedeploy_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.ecs_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_policy_document.role_policy_devops_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.role_policy_ecs_task_execution_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.role_policy_ecs_task_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_kms_key.ssm](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/kms_key) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_attach_to"></a> [attach\_to](#input\_attach\_to) | The ARN or role name to attach the policy created | `string` | `""` | no |
| <a name="input_code_deploy_resources"></a> [code\_deploy\_resources](#input\_code\_deploy\_resources) | The Code Deploy applications and deployment groups to which grant IAM access | `list(string)` | <pre>[<br>  "*"<br>]</pre> | no |
| <a name="input_create_codedeploy_role"></a> [create\_codedeploy\_role](#input\_create\_codedeploy\_role) | Set this variable to true if you want to create a role for AWS CodeDeploy | `bool` | `false` | no |
| <a name="input_create_devops_policy"></a> [create\_devops\_policy](#input\_create\_devops\_policy) | Set this variable to true if you want to create a policy for AWS DevOps Tools | `bool` | `false` | no |
| <a name="input_create_devops_role"></a> [create\_devops\_role](#input\_create\_devops\_role) | Set this variable to true if you want to create a role for AWS DevOps Tools | `bool` | `false` | no |
| <a name="input_create_ecs_role"></a> [create\_ecs\_role](#input\_create\_ecs\_role) | Set this variable to true if you want to create a role for ECS | `bool` | `false` | no |
| <a name="input_create_policy"></a> [create\_policy](#input\_create\_policy) | Set this variable to true if you want to create an IAM Policy | `bool` | `false` | no |
| <a name="input_dynamodb_table"></a> [dynamodb\_table](#input\_dynamodb\_table) | The name of the Dynamodb table to which grant IAM access | `list(string)` | <pre>[<br>  "*"<br>]</pre> | no |
| <a name="input_ecr_repositories"></a> [ecr\_repositories](#input\_ecr\_repositories) | The ECR repositories to which grant IAM access | `list(string)` | <pre>[<br>  "*"<br>]</pre> | no |
| <a name="input_name"></a> [name](#input\_name) | The name for the Role | `string` | n/a | yes |
| <a name="input_name_ecs_task_role"></a> [name\_ecs\_task\_role](#input\_name\_ecs\_task\_role) | The name for the Ecs Task Role | `string` | `null` | no |
| <a name="input_s3_bucket_assets"></a> [s3\_bucket\_assets](#input\_s3\_bucket\_assets) | The name of the S3 bucket to which grant IAM access | `list(string)` | <pre>[<br>  "*"<br>]</pre> | no |
| <a name="input_ssm_parameters"></a> [ssm\_parameters](#input\_ssm\_parameters) | n/a | `list(string)` | <pre>[<br>  "*"<br>]</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn_role"></a> [arn\_role](#output\_arn\_role) | n/a |
| <a name="output_arn_role_codedeploy"></a> [arn\_role\_codedeploy](#output\_arn\_role\_codedeploy) | n/a |
| <a name="output_arn_role_ecs_task_role"></a> [arn\_role\_ecs\_task\_role](#output\_arn\_role\_ecs\_task\_role) | n/a |
| <a name="output_name_role"></a> [name\_role](#output\_name\_role) | n/a |
