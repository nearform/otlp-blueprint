set -e
namespace="${1:-$NAMESPACE}"

kubectl create namespace $namespace ||  true

sed "s/.test./.$namespace./g" ./../manifest/jaeger.yaml | kubectl apply -n $namespace -f -

kubectl apply -f ./../manifest/postgresql.yaml -n $namespace

# Todo: The backend app seems not to be able to reconnect to PG if the connection fails when the app is booting
sleep 10
####

sed "s/.test./.otlp./g" ./../manifest/collector.yaml | kubectl apply -n otlp -f -

sed 's/image: .*/image: otlp-blueprint-frontend/g' ./../manifest/frontend.yaml | sed 's/imagePullPolicy:.*/imagePullPolicy: IfNotPresent/g' | kubectl apply -n $namespace -f -

sed 's/image: .*/image: otlp-blueprint-backend/g' ./../manifest/backend.yaml | \
  sed 's/imagePullPolicy:.*/imagePullPolicy: IfNotPresent/g' | \
  sed "s/.test./.$namespace./g" | kubectl apply -n $namespace -f -
