set -e

NAMESPACE=test

pushd ../
echo "Build FE image"
docker build --build-arg="API_URL=http://127.0.0.1:3000"  --build-arg="OTLP_COLLECTOR_URL=http://127.0.0.1:4318" -t otlp-blueprint-frontend -f Frontend.dockerfile .
echo "Build BE image"
docker build -t otlp-blueprint-backend -f Backend.dockerfile .
popd

echo "Create the kind cluster"
kind create cluster

echo "Load the images"
kind load docker-image otlp-blueprint-frontend
kind load docker-image otlp-blueprint-backend

echo "Install the required operators"
kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.12.0/cert-manager.yaml
sleep 20
kubectl apply -f https://github.com/open-telemetry/opentelemetry-operator/releases/latest/download/opentelemetry-operator.yaml
sleep 20

echo "Create the namespace"
kubectl create namespace $NAMESPACE ||  true

echo "Install Jaeger"
kubectl apply -f ./manifest/jaeger.yaml -n $NAMESPACE

echo "Install PG"
kubectl apply -f ./manifest/postgresql.yaml -n $NAMESPACE

sleep 10

echo "Install the collector"
kubectl apply -f ./manifest/collector.yaml -n $NAMESPACE

echo "Install FE and BE"
sed 's/image: .*/image: otlp-blueprint-frontend/g' ./manifest/frontend.yaml | sed 's/imagePullPolicy:.*/imagePullPolicy: IfNotPresent/g' | kubectl apply -n $NAMESPACE -f -
sed 's/image: .*/image: otlp-blueprint-backend/g' ./manifest/backend.yaml | sed 's/imagePullPolicy:.*/imagePullPolicy: IfNotPresent/g' | kubectl apply -n $NAMESPACE -f -


