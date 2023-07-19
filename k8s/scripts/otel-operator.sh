set -e

cert_manager="${1:-$INSTALL_CERT_MANAGER}"
otel_operator="${2:-$INSTALL_OTEL_OPERATOR}"

if [ "$cert_manager" = true ]; then
  # Install cert-manager
  kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.12.0/cert-manager.yaml
else
  echo "Skipping cert-manager installation."
fi
if [ "$otel_operator" = true ]; then
  # Install opentelemetry-operator
  kubectl apply -f https://github.com/open-telemetry/opentelemetry-operator/releases/latest/download/opentelemetry-operator.yaml
else
  echo "Skipping opentelemetry-operator installation."
fi