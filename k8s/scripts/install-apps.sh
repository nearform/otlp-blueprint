set -e

# TODO: this must be a parameter
NAMESPACE=test

kubectl create namespace $NAMESPACE ||  true
kubectl apply -f ./manifest/jaeger.yaml -n $NAMESPACE
kubectl apply -f ./manifest/postgresql.yaml -n $NAMESPACE

# Todo: The backend app seems not to be able to reconnect to PG if the connection fails when the app is booting
sleep 10
####


kubectl apply -f ./manifest/collector.yaml -n $NAMESPACE
sed 's/image: .*/image: otlp-blueprint-frontend/g' ./manifest/frontend.yaml | sed 's/imagePullPolicy:.*/imagePullPolicy: IfNotPresent/g' | kubectl apply -n $NAMESPACE -f -
sed 's/image: .*/image: otlp-blueprint-backend/g' ./manifest/backend.yaml | sed 's/imagePullPolicy:.*/imagePullPolicy: IfNotPresent/g' | kubectl apply -n $NAMESPACE -f -
