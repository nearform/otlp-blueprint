set -e

image_suffix=${1:-"otlp-blueprint"}

cd ../
  docker build -t "$image_suffix"-backend -f Backend.dockerfile .
