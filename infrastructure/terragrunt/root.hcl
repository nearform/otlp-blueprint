# Root terragrunt config used for remote backend setup, and provider generator, etc.
locals {

  # AWS setting
  aws_profile = "otlp_dev"

  # Load environment config.
  environment_config = read_terragrunt_config(find_in_parent_folders("environment.hcl"))

  deployments_root_dir = get_parent_terragrunt_dir() # infrastructure/terragrunt

  deployment_app_name       = "otlp"
  deployment_relative_path  = path_relative_to_include() # /dev/us-east-1/test/test/
  deployment_path_array     = split("/", local.deployment_relative_path)
  deployment_terragrunt_dir = get_terragrunt_dir()        # 
  deployment_parent_dir     = get_parent_terragrunt_dir() # 
  deployment_env            = local.deployment_path_array[0]
  deployment_region         = local.deployment_path_array[1] # In our case we get it from path and this may be overriden by region in environment.hcl in the sub folder.
  deployment_stack          = local.deployment_path_array[2]
  deployment_stack_service  = local.deployment_path_array[3]

  # Backend tfstate key name 
  backend_tfstate_key_name = "${local.deployment_env}/${local.deployment_region}/${local.deployment_stack}/${local.deployment_stack_service}/terraform.tfstate"

  # default tags to be added to the resources that we create.
  default_tags = {
    Name  = "Open Telemetry Project"
    Owner = "Terraform/Terragrunt"
  }

}

# ...and make them available as inputs
inputs = {
  deployment_relative_path = local.deployment_relative_path
  deployment_env           = local.deployment_env
  deployment_parent_dir    = local.deployment_parent_dir
  deployment_region        = local.deployment_region
  backend_tfstate_key_name = local.backend_tfstate_key_name
  tags                     = merge(local.default_tags, local.environment_config.locals.region_tags)
  deployment_app_name      = local.deployment_app_name
  deployment_stack         = local.deployment_stack
  deployment_stack_service = local.deployment_stack_service

  # Netorwking related inputs
  vpc_cidr_block = "192.168.0.0/16"
  az_count       = 2

  # Application Load balancer
  app_health_check_path = "/" # used in target group with nginx backend.
}

# Default the stack each deployment deploys based on its directory structure
# Can be overridden by redefining this block in a child terragrunt.hcl
terraform {
  source = "${local.deployments_root_dir}/../terraform/${local.deployment_stack}/${local.deployment_stack_service}"
}

# Comment this for initial setup
// TODO: #47 aws profile set here in the provider file doesn't work.
generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
      provider "aws" {
        # Configuration options
        region = "${local.deployment_region}"
        profile = "${local.aws_profile}" 
      }
      terraform {
        required_providers {
          random = {
            source  = "hashicorp/random"
            version = "3.1.3"
          }
          aws = {
            source = "hashicorp/aws"
            version = "4.14.0"
          }
        }
      }
      EOF
}



# Remote State Configuration
# --------------------------
remote_state {

  disable_init = tobool(get_env("DISABLE_INIT", "false"))
  backend      = "s3"

  config = {
    encrypt = true
    bucket  = "otlp-blueprint-tf-state"
    key     = local.backend_tfstate_key_name
    region  = "us-east-1"
  }

  #for terraform to know it must use s3 backend
  #we should generate a file and place it in the product
  #before running.
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite"
  }
}