#!/usr/bin/env bash
set -eu
set -o pipefail

repo_dir_name=$(dirname "$(cd "$(dirname "${BASH_SOURCE[0]}")" &> /dev/null && pwd)")

cp ${repo_dir_name}/Code/client/snapshot.zip .
unzip snapshot.zip -d ${repo_dir_name}/bundle
S3_BUCKET=$(cat ${repo_dir_name}/scripts/outputs.json| jq -r .aws_s3_bucket_site_id.value)
aws s3 cp ${repo_dir_name}/bundle/build/ s3://${S3_BUCKET}/ --recursive
rm -rf ${repo_dir_name}/bundle