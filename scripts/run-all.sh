#!/usr/bin/env bash
set -eu
set -o pipefail

repo_dir_name=$(dirname "$(cd "$(dirname "${BASH_SOURCE[0]}")" &> /dev/null && pwd)")
#echo $repo_dir_name
sh ${repo_dir_name}/scripts/tf-apply.sh
sh ${repo_dir_name}/scripts/fe-unit-tests.sh
sh ${repo_dir_name}/scripts/fe-build.sh
sh ${repo_dir_name}/scripts/be-unit-tests.sh
sh ${repo_dir_name}/scripts/be-build.sh
sh ${repo_dir_name}/scripts/be-push.sh
sh ${repo_dir_name}/scripts/be-deploy.sh
sh ${repo_dir_name}/scripts/fe-deploy.sh
sh ${repo_dir_name}/scripts/cleanup.sh