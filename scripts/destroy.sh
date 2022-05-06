#!/usr/bin/env bash
set -eu
set -o pipefail

repo_dir_name=$(dirname "$(cd "$(dirname "${BASH_SOURCE[0]}")" &> /dev/null && pwd)")

cd ${repo_dir_name}/Infrastructure/terragrunt/dev/eu-west-1/main
terragrunt run-all destroy -var aws_region="eu-west-1" -var environment_name="dev" --terragrunt-non-interactive