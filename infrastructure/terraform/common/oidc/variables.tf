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

variable "oidc_thumbprint" {
  description = "Thumbprint_list of the oidc provider"
  type        = list(string)
}
