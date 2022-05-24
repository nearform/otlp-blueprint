variable "deployment_relative_path" {}

variable "deployment_env" {}

variable "deployment_parent_dir" {}

variable "deployment_region" {}

variable "deployment_stack" {}

variable "deployment_stack_service" {}

variable "backend_tfstate_key_name" {}

variable "tags" {
    type  = map
}

resource "random_pet" "pet" {
}