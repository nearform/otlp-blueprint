#!/bin/bash

# Check if input parameters are provided
if [ "$#" -ne 2 ]; then
  echo "Usage: $0 <cluster_name> <region>"
  exit 1
fi

cluster_name=$1
region=$2

# Function to update and wait for a single service
update_service() {
  local cluster_name=$1
  local region=$2
  local service_name=$3

  echo "Updating service: $service_name"
  aws ecs update-service --cluster "${cluster_name}" --region "${region}" --service "${service_name}" --force-new-deployment
  aws ecs wait services-stable --cluster "${cluster_name}" --region "${region}" --services "${service_name}"
  echo "Service updated and stable: $service_name"
}

# Get the list of services in the cluster
services=$(aws ecs list-services --cluster "${cluster_name}" --region "${region}" | jq -r '.serviceArns[]')

# Start background jobs to update services in parallel
for service_arn in $services; do
  service_name=$(echo "$service_arn" | awk -F '/' '{print $3}')
  update_service "${cluster_name}" "${region}" "${service_name}" &
done

# Wait for all background jobs to complete
wait

echo "All services have been updated."
