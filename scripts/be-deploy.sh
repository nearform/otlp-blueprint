#!/usr/bin/env bash
set -eu
set -o pipefail

repo_dir_name=$(dirname "$(cd "$(dirname "${BASH_SOURCE[0]}")" &> /dev/null && pwd)")


cp ${repo_dir_name}/appspec.yaml ${repo_dir_name}/scripts
cp ${repo_dir_name}/taskdef.json ${repo_dir_name}/scripts
cp ${repo_dir_name}/create-deployment.json ${repo_dir_name}/scripts
APPLICATION_NAME=$(cat ${repo_dir_name}/scripts/outputs.json| jq -r .application_name.value)
DEPLOYMENT_GROUP_NAME=$(cat ${repo_dir_name}/scripts/outputs.json| jq -r .deployment_group_name.value)
TASK_DEFINITION_FAMILY=$(cat ${repo_dir_name}/scripts/outputs.json| jq -r .task_definition_family.value)
CONTAINER_NAME=Container-server
SERVICE_PORT=3000
ECS_ROLE=$(cat ${repo_dir_name}/scripts/outputs.json| jq -r .ecs_role.value)
ECS_TASK_ROLE=$(cat ${repo_dir_name}/scripts/outputs.json| jq -r .ecs_task_role.value)
AWS_ACCOUNT_ID=$(aws sts get-caller-identity --query Account --output text)
AWS_REGION=eu-west-1
REPO_URL=$(cat ${repo_dir_name}/scripts/outputs.json| jq -r .ecr_repository_url.value)
s3_assets_bucket=$(cat ${repo_dir_name}/scripts/outputs.json| jq -r .aws_s3_assets_bucket_id.value)
sed -i "s|<TASK_DEFINITION_FAMILY>|$TASK_DEFINITION_FAMILY|g" ${repo_dir_name}/scripts/taskdef.json
sed -i "s|<CONTAINER_NAME>|$CONTAINER_NAME|g" ${repo_dir_name}/scripts/appspec.yaml ${repo_dir_name}/scripts/taskdef.json
sed -i "s|<SERVICE_PORT>|$SERVICE_PORT|g" ${repo_dir_name}/scripts/appspec.yaml ${repo_dir_name}/scripts/taskdef.json
sed -i "s|<ECS_ROLE>|$ECS_ROLE|g" ${repo_dir_name}/scripts/taskdef.json
sed -i "s|<ECS_TASK_ROLE>|$ECS_TASK_ROLE|g" ${repo_dir_name}/scripts/taskdef.json
sed -i "s|<REPO_URL>|$REPO_URL|g" ${repo_dir_name}/scripts/taskdef.json
sed -i "s|<AWS_ACCOUNT_ID>|$AWS_ACCOUNT_ID|g" ${repo_dir_name}/scripts/taskdef.json
sed -i "s|<AWS_REGION>|$AWS_REGION|g" ${repo_dir_name}/scripts/taskdef.json
TASK_DEFINITION_ARN=$(aws ecs register-task-definition \
--cli-input-json file://${repo_dir_name}/scripts/taskdef.json | jq -r .taskDefinition.taskDefinitionArn)
sed -i "s|<TASK_DEFINITION>|$TASK_DEFINITION_ARN|g" ${repo_dir_name}/scripts/appspec.yaml
aws s3 cp ${repo_dir_name}/scripts/appspec.yaml s3://${s3_assets_bucket}/appspec.yaml
sed -i "s|<S3_ASSETS_BUCKET>|$s3_assets_bucket|g" ${repo_dir_name}/scripts/create-deployment.json
sed -i "s|<APPLICATION_NAME>|$APPLICATION_NAME|g" ${repo_dir_name}/scripts/create-deployment.json
sed -i "s|<DEPLOYMENT_GROUP_NAME>|$DEPLOYMENT_GROUP_NAME|g" ${repo_dir_name}/scripts/create-deployment.json
# cat ${repo_dir_name}/scripts/create-deployment.json
DEPLOYMENT_ID=$(aws deploy create-deployment \
--cli-input-json file://${repo_dir_name}/scripts/create-deployment.json \
--region eu-west-1 | jq -r .deploymentId)
aws deploy wait deployment-successful --deployment-id ${DEPLOYMENT_ID}
