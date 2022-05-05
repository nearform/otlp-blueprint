#!/usr/bin/env bash
set -eu
set -o pipefail

repo_dir_name=$(dirname "$(cd "$(dirname "${BASH_SOURCE[0]}")" &> /dev/null && pwd)")

pushd .
cd ${repo_dir_name}/Infrastructure/terragrunt/dev/eu-west-1/main
terragrunt run-all ${1:-apply} -var aws_region="eu-west-1" -var environment_name="dev" --terragrunt-non-interactive
terragrunt output -json > outputs.json
#ORIGINAL_PATH=$(dirs | awk '{ printf $2 }') # not sure why it doesn't work
cp outputs.json ${repo_dir_name}/scripts
popd