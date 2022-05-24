include "root" {
  path = find_in_parent_folders("root.hcl")
}

include "environment" {
  path = find_in_parent_folders("environment.hcl")
}



// networking dependency - vpc_id

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
inputs = {
  vpc_id             = dependency.networking.outputs.vpc_id
}
