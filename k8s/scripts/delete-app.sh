set -e

namespace="${1:-$NAMESPACE_NAME}"
app="$2"

kubectl delete -f ./manifest/"$app".yaml -n $namespace
