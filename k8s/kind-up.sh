set -e

NAMESPACE=test

#pushd ../
#echo "Build FE image"
#docker build --build-arg="API_URL=http://127.0.0.1:3000" -t otlp-blueprint-frontend -f Frontend.dockerfile .
#echo "Build BE image"
#docker build -t otlp-blueprint-backend -f Backend.dockerfile .
#popd
#
#echo "Create the kind cluster"
#kind create cluster

#echo "Load the images"
#kind load docker-image otlp-blueprint-frontend
#kind load docker-image otlp-blueprint-backend

#echo "Install the required operators"
#kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.12.0/cert-manager.yaml
#sleep 10
#kubectl apply -f https://github.com/open-telemetry/opentelemetry-operator/releases/latest/download/opentelemetry-operator.yaml

echo "Create the namespace"
kubectl create namespace $NAMESPACE ||  true

echo "Install Jaeger"
kubectl apply -f ./manifest/jaeger.yaml -n $NAMESPACE

echo "Install PG"
kubectl apply -f ./manifest/postgresql.yaml -n $NAMESPACE

echo "Install the collector"
kubectl apply -f ./manifest/collector.yaml -n $NAMESPACE

echo "Install FE and BE"
export FRONTEND_IMAGE=otlp-blueprint-frontend
export BACKEND_IMAGE=otlp-blueprint-backend
export IMAGE_PULL_POLICY=IfNotPresent
envsubst < ./manifest/frontend.yaml | kubectl apply -n $NAMESPACE -f -


