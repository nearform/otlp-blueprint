include "root" {
  path = find_in_parent_folders("root.hcl")
}

include "environment" {
  path = find_in_parent_folders("environment.hcl")
}


inputs = {
  oidc_url = "https://token.actions.githubusercontent.com"
  oidc_audience = "sts.amazonaws.com"
  oidc_thumbprint = ["6938fd4d98bab03faadb97b34396831e3780aea1"]
}