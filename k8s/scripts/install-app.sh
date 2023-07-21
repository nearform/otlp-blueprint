set -e

namespace="${1:-$NAMESPACE_NAME}"
app="$2"

sed "s/.\${NAMESPACE_NAME}./.$namespace./g" ./manifest/"$app".yaml | kubectl apply -n $namespace -f -
