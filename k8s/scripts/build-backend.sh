set -e

image_suffix="${1:-"otlp-blueprint"}"

pushd ../
  docker build -t "$image_suffix"-backend -f Backend.dockerfile .
popd
