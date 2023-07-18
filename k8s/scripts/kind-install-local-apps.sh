set -e
namespace="${1:-$NAMESPACE_NAME}"
image_suffix="$2"

kind load docker-image "$image_suffix"-frontend
kind load docker-image "$image_suffix"-backend

sed 's/image: .*/image: otlp-blueprint-frontend/g' ./manifest/frontend.yaml | sed 's/imagePullPolicy:.*/imagePullPolicy: IfNotPresent/g' | kubectl apply -n $namespace -f -

sed 's/image: .*/image: otlp-blueprint-backend/g' ./manifest/backend.yaml | \
  sed 's/imagePullPolicy:.*/imagePullPolicy: IfNotPresent/g' | \
  sed "s/.test./.$namespace./g" | kubectl apply -n $namespace -f -
