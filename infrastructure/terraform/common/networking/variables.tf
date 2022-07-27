variable "tags" {
  type = map(any)
}

variable "deployment_region" {}

variable "deployment_env" {}

variable "deployment_app_name" {}

variable "vpc_cidr_block" {
  description = "The CIDR block for the VPC. Default value is a valid CIDR, but not acceptable by AWS and should be overridden"
  type        = string
  default     = "172.16.0.0/16"
}

variable "az_count" {
  type        = number
  description = "Number of AZs to cover in a given region"
  default     = 2
}
