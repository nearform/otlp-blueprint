variable "deployment_env" {}

variable "deployment_app_name" {}

variable "oidc_url" {
  description = "For the provider URL"
  type        = string
}

variable "oidc_audience" {
  description = "For the 'Audience'"
  type        = string
}
