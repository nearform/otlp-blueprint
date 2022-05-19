# Environment specific variables need to go here.
# Note that locals are not inherited by either the child nor by parent. If we need this use include.
locals {

  deployment_region = "us-east-1" # use get_env to read the region from environment variable.

  # include locals to manage the aws creds
  region_tags = {
    region = local.deployment_region
  }

}
