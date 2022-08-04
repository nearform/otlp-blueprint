#!/usr/bin/env bash
set -eu
set -o pipefail

repo_dir_name=$(dirname "$(cd "$(dirname "${BASH_SOURCE[0]}")" &> /dev/null && pwd)")
REPO_URL=$(cat ${repo_dir_name}/scripts/outputs.json| jq -r .ecr_repository_url.value)
AWS_ACCOUNT_ID=$(aws sts get-caller-identity --query Account --output text)
aws ecr get-login-password --region $AWS_REGION | docker login --username AWS --password-stdin $AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com
docker build -t $REPO_URL ${repo_dir_name}/pkg-svcs/backend

docker push $REPO_URL:latest