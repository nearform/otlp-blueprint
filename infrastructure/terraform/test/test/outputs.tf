output "pet" {
  value = random_pet.pet.id
}

output "deployment_relative_path" {
    value = var.deployment_relative_path
}

output "deployment_env" {
  value = var.deployment_env

}

output "deployment_parent_dir" {
  value = var.deployment_parent_dir
}
output "deployment_region" {
  value = var.deployment_region
}

output "deployment_stack" {
  value = var.deployment_stack
}

output "deployment_stack_service" {
  value = var.deployment_stack_service
}

output "backend_tfstate_key_name" {
  value = var.backend_tfstate_key_name
}

output "tags" {
  value = var.tags
}