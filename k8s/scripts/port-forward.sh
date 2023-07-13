set -e

NAMESPACE=test

kubectl port-forward $(kubectl get pods -n test -l app=backend -o Name) 3000:3000 -n $NAMESPACE &
kubectl port-forward $(kubectl get pods -n test -l app=frontend -o Name) 8080:8080 -n $NAMESPACE &
kubectl port-forward $(kubectl get pods -n test -l app.kubernetes.io/name=main-collector -o Name) 4318:4318 -n $NAMESPACE &
kubectl port-forward $(kubectl get pods -n test -l app.kubernetes.io/name=jaeger -o Name) 16686:16686 -n $NAMESPACE &
