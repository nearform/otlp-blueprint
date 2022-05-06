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
| [aws_default_route_table.rt_public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/default_route_table) | resource |
| [aws_eip.eip](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip) | resource |
| [aws_internet_gateway.igw](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway) | resource |
| [aws_nat_gateway.natgw](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/nat_gateway) | resource |
| [aws_route_table.rt_private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table_association.rt_assoc_priv_subnets_server](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_route_table_association.rt_assoc_pub_subnets](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_subnet.private_subnets_server](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_subnet.public_subnets](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_vpc.aws_vpc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc) | resource |
| [aws_availability_zones.az_availables](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/availability_zones) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cidr"></a> [cidr](#input\_cidr) | CIDR block | `list(any)` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | Provided name used for name concatenation of resources | `string` | n/a | yes |
| <a name="input_subnets_number"></a> [subnets\_number](#input\_subnets\_number) | Number of subnets to create (independent from type) | `number` | `2` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_aws_vpc"></a> [aws\_vpc](#output\_aws\_vpc) | n/a |
| <a name="output_private_subnets_server"></a> [private\_subnets\_server](#output\_private\_subnets\_server) | n/a |
| <a name="output_public_subnets"></a> [public\_subnets](#output\_public\_subnets) | n/a |
