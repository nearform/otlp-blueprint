#!/bin/bash

set -e
cert_manager="${1:-$INSTALL_CERT_MANAGER}"
otel_operator="${2:-$INSTALL_OTEL_OPERATOR}"

# Function to check if a Kubernetes resource is ready
function check_operator {
  local timeout="${2:-30}" # Default timeout: 30 seconds

  local start_time=$(date +%s)
  while true; do
    if kubectl get deployment.apps/opentelemetry-operator-controller-manager -n opentelemetry-operator-system -o json | jq '.status.conditions[] | select(.type == "Available") | .status' | grep -q "True"; then
      echo "opentelemetry-operator-system is ready."
      break
    fi

    local current_time=$(date +%s)
    local elapsed_time=$((current_time - start_time))
    if [ "$elapsed_time" -ge "$timeout" ]; then
      echo "Timeout: opentelemetry-operator-system did not become ready within $timeout seconds."
      exit 1
    fi

    echo "Waiting for opentelemetry-operator-system to become ready..."
    sleep 5
  done
}

function check_cert_manager {
  local timeout="${2:-30}" # Default timeout: 30 seconds

  local start_time=$(date +%s)
  while true; do
    if kubectl get deployment.apps/cert-manager -n cert-manager -o json | jq '.status.conditions[] | select(.type == "Available") | .status' | grep -q "True"; then
      echo "cert-manager is ready."
      break
    fi
    if kubectl get deployment.apps/cert-manager-cainjector -n cert-manager -o json | jq '.status.conditions[] | select(.type == "Available") | .status' | grep -q "True"; then
      echo "cert-manager-cainjector is ready."
      break
    fi
    if kubectl get deployment.apps/cert-manager-webhook -n cert-manager -o json | jq '.status.conditions[] | select(.type == "Available") | .status' | grep -q "True"; then
      echo "cert-manager-webhook is ready."
      break
    fi

    local current_time=$(date +%s)
    local elapsed_time=$((current_time - start_time))
    if [ "$elapsed_time" -ge "$timeout" ]; then
      echo "Timeout: cert-manager did not become ready within $timeout seconds."
      exit 1
    fi

    echo "Waiting for cert-manager-system to become ready..."
    sleep 5
  done
}


if [ "$cert_manager" = true ]; then
  # Install cert-manager
  kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.12.0/cert-manager.yaml
  check_cert_manager
else
  echo "Skipping cert-manager installation."
fi

if [ "$otel_operator" = true ]; then
  # Install opentelemetry-operator
  kubectl apply -f https://github.com/open-telemetry/opentelemetry-operator/releases/latest/download/opentelemetry-operator.yaml
  check_operator
else
  echo "Skipping opentelemetry-operator installation."
fi
