locals {
    fe_image_repo_name = "${var.deployment_env}-${var.deployment_app_name}-fe-img-repo"
    be_image_repo_name = "${var.deployment_env}-${var.deployment_app_name}-be-img-repo"

}

resource "aws_ecr_repository" "otlp-fe-image-repo" {
  name                 = local.fe_image_repo_name
  image_tag_mutability = "IMMUTABLE"
}

resource "aws_ecr_repository_policy" "fe-image-repo-policy" {
  repository = aws_ecr_repository.otlp-fe-image-repo.name
  policy     = <<EOF
  {
    "Version": "2008-10-17",
    "Statement": [
      {
        "Sid": "adds full ecr access to the demo repository",
        "Effect": "Allow",
        "Principal": "*",
        "Action": [
          "ecr:BatchCheckLayerAvailability",
          "ecr:BatchGetImage",
          "ecr:CompleteLayerUpload",
          "ecr:GetDownloadUrlForLayer",
          "ecr:GetLifecyclePolicy",
          "ecr:InitiateLayerUpload",
          "ecr:PutImage",
          "ecr:UploadLayerPart"
        ]
      }
    ]
  }
  EOF
}


resource "aws_ecr_repository" "otlp-be-image-repo" {
  name                 = local.be_image_repo_name
  image_tag_mutability = "IMMUTABLE"
}

resource "aws_ecr_repository_policy" "be-image-repo-policy" {
  repository = aws_ecr_repository.otlp-be-image-repo.name
  policy     = <<EOF
  {
    "Version": "2008-10-17",
    "Statement": [
      {
        "Sid": "adds full ecr access to the demo repository",
        "Effect": "Allow",
        "Principal": "*",
        "Action": [
          "ecr:BatchCheckLayerAvailability",
          "ecr:BatchGetImage",
          "ecr:CompleteLayerUpload",
          "ecr:GetDownloadUrlForLayer",
          "ecr:GetLifecyclePolicy",
          "ecr:InitiateLayerUpload",
          "ecr:PutImage",
          "ecr:UploadLayerPart"
        ]
      }
    ]
  }
  EOF
}