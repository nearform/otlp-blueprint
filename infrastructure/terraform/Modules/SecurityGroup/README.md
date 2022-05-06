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
| [aws_security_group.sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cidr_blocks_egress"></a> [cidr\_blocks\_egress](#input\_cidr\_blocks\_egress) | An ingress block of CIDR to grant access to | `list(any)` | <pre>[<br>  "0.0.0.0/0"<br>]</pre> | no |
| <a name="input_cidr_blocks_ingress"></a> [cidr\_blocks\_ingress](#input\_cidr\_blocks\_ingress) | An ingress block of CIDR to grant access to | `list(any)` | `null` | no |
| <a name="input_description"></a> [description](#input\_description) | A description of the purpose | `string` | n/a | yes |
| <a name="input_egress_port"></a> [egress\_port](#input\_egress\_port) | Number of the port to open in the egress rules | `number` | `0` | no |
| <a name="input_ingress_port"></a> [ingress\_port](#input\_ingress\_port) | Number of the port to open in the ingress rules | `number` | `0` | no |
| <a name="input_name"></a> [name](#input\_name) | The name of your security group | `string` | n/a | yes |
| <a name="input_security_groups"></a> [security\_groups](#input\_security\_groups) | List of security group Group Names if using EC2-Classic, or Group IDs if using a VPC | `list(any)` | `null` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | The ID of the VPC where the security group will take place | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_sg_id"></a> [sg\_id](#output\_sg\_id) | n/a |
