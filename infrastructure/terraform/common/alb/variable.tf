variable "tags" {
    type = map
}

variable "deployment_region" {} 

variable "deployment_env" {}

variable "deployment_app_name" {}


variable "app_health_check_path" {}

variable "vpc_id" {}

variable "public_subnet_ids" {
    type = set(string)
}

variable "private_subnet_ids" {
    type = set(string)

}

variable "sg_alb_id" {}

variable "sg_ecs_id" {}

variable "alb_dns_zone" {
  type        = string
  description = "The AWS Route53 Zone to use to create the ALB's DNS record."
}
