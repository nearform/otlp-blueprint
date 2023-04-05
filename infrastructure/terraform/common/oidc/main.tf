module "iam_iam-assumable-role-with-oidc" {
  role_name = "${var.deployment_env}-${var.deployment_app_name}-github-actions-role"
  source  = "terraform-aws-modules/iam/aws//modules/iam-assumable-role-with-oidc"
  version = "5.5.5"
  force_detach_policies = true
  create_role = true
  provider_url = var.oidc_url
  oidc_fully_qualified_audiences = ["${var.oidc_audience}"]
  allow_self_assume_role = false
  role_policy_arns = ["arn:aws:iam::aws:policy/AdministratorAccess"]
  oidc_subjects_with_wildcards = ["repo:nearform/otlp-blueprint:*"]

}