set -e
namespace="${1:-$NAMESPACE}"


kubectl port-forward $(kubectl get pods -n $namespace -l app=frontend -o Name) 8080:8080 -n $namespace &
kubectl port-forward -n $namespace service/main-collector 4318 &
kubectl port-forward $(kubectl get pods -n $namespace -l app.kubernetes.io/name=jaeger -o Name) 16686:16686 -n $namespace &
kubectl port-forward $(kubectl get pods -n $namespace -l app=backend -o Name) 3000:3000 -n $namespace &

