#!/usr/bin/env bash
set -eu
set -o pipefail

repo_dir_name=$(dirname "$(cd "$(dirname "${BASH_SOURCE[0]}")" &> /dev/null && pwd)")

REPO_URL=$(cat ${repo_dir_name}/scripts/outputs.json| jq -r .ecr_repository_url.value)
docker push $REPO_URL:latest