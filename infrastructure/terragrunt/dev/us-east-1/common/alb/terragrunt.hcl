# locals 
locals {

}

# Includes
include "root" {
  path = find_in_parent_folders("root.hcl")
}

include "environment" {
  path = find_in_parent_folders("environment.hcl")
}

# Dependencies 
dependency "networking" {
  config_path = "../networking"

  # Mock outputs for plan to work
  mock_outputs = {
    vpc_id             = "sfasdfasdfasdfas"
    public_subnet_ids  = toset(["Asdfasdfasdfasd", "Asdfasdfasdfasdf"])
    private_subnet_ids = toset(["asdfasdfasdfasdfsf", "Asdfasdfasdasdfsad"])
  }
}
dependency "sg" {
  config_path = "../sg"

  mock_outputs = {
    sg_ecs_id = "3223423423fsadfsdfasd"
    sg_alb_id = "sasdfs232342342"
  }
}

inputs = {
  vpc_id             = dependency.networking.outputs.vpc_id
  public_subnet_ids  = dependency.networking.outputs.public_subnet_ids
  private_subnet_ids = dependency.networking.outputs.private_subnet_ids
  sg_ecs_id          = dependency.sg.outputs.sg_ecs_id
  sg_alb_id          = dependency.sg.outputs.sg_alb_id
}
