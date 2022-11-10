// resource "aws_iam_openid_connect_provider" "default" {
//   url = var.oidc_url

//   client_id_list = [
//     var.oidc_audience,
//   ]
// #https://github.blog/changelog/2022-01-13-github-actions-update-on-oidc-based-deployments-to-aws/#:~:text=In%20the%20AWS%20Console%2C%20go,Add%20the%20thumbprint%206938fd4d98bab03faadb97b34396831e3780aea1
//   thumbprint_list = var.oidc_thumbprint
// }

module "iam_iam-assumable-role-with-oidc" {
  role_name = "${var.deployment_env}-${var.deployment_app_name}-github-actions-role"
  source  = "terraform-aws-modules/iam/aws//modules/iam-assumable-role-with-oidc"
  version = "5.5.5"
  force_detach_policies = true
  create_role = true
  provider_url = var.oidc_url
  oidc_fully_qualified_audiences = ["${var.oidc_audience}"]
  allow_self_assume_role = false
  role_policy_arns = ["arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryFullAccess","arn:aws:iam::aws:policy/AmazonECS_FullAccess"]
  oidc_subjects_with_wildcards = ["repo:nearform/otlp-blueprint:*"]

}