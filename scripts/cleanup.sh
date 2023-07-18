#!/usr/bin/env bash
set -eu
set -o pipefail

repo_dir_name=$(dirname "$(cd "$(dirname "${BASH_SOURCE[0]}")" &> /dev/null && pwd)")

rm ${repo_dir_name}/scripts/appspec.yaml
rm ${repo_dir_name}/scripts/create-deployment.json
rm ${repo_dir_name}/scripts/taskdef.json
rm ${repo_dir_name}/scripts/outputs.json