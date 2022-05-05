terraform {
  source = "${path_relative_from_include()}/../terraform"
}

locals {
    dirs       = split("/", path_relative_to_include())
    env        = lower(local.dirs[0]) # dir structure <repo>/<env>/<region>/<cluster_name>/
    aws_region = lower(local.dirs[1]) # dir structure <repo>/<env>/<region>/<cluster_name>/
    stack_name = lower(local.dirs[2]) # dir structure <repo>/<env>/<region>/<cluster_name>/

    key_name   = "${local.env}/${local.aws_region}/${local.stack_name}/terraform.tfstate"
}
# Remote State Configuration
# --------------------------
remote_state {

  disable_init = tobool(get_env("DISABLE_INIT", "false"))
  backend      = "s3"

  config = {
    encrypt             = true
    bucket              = "3-tier-tf-state"
    dynamodb_table      = "3-tier-tf"
    key                 = local.key_name
    region              = local.aws_region
  }

  #for terraform to know it must use s3 backend
  #we should generate a file and place it in the product
  #before running.
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite"
  }
}

inputs = {
  aws_region = local.aws_region
  environment_name = local.env
}