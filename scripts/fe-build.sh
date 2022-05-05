#!/usr/bin/env bash
set -eu
set -o pipefail

repo_dir_name=$(dirname "$(cd "$(dirname "${BASH_SOURCE[0]}")" &> /dev/null && pwd)")

ALB_DNS=$(cat ${repo_dir_name}/scripts/outputs.json| jq -r .alb_endpoint.value)
cd ${repo_dir_name}/Code/client
cp ./src/App.js ./src/App.js_bak
sed -i "s|<ALB_DNS>|$ALB_DNS|g" ./src/App.js
npm install --production
npm run build
zip -r snapshot.zip ./build/
mv ./src/App.js_bak ./src/App.js
