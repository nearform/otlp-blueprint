#!/usr/bin/env bash
set -eu
set -o pipefail

repo_dir_name=$(dirname "$(cd "$(dirname "${BASH_SOURCE[0]}")" &> /dev/null && pwd)")

cd ${repo_dir_name}/Infrastructure/terragrunt/dev/$AWS_REGION/main
terragrunt run-all destroy -var aws_region=$AWS_REGION -var environment_name="dev" --terragrunt-non-interactive