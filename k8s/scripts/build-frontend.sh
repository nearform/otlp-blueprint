set -e

image_suffix="${1:-"otlp-blueprint"}"

cd ../
  docker build --build-arg="API_URL=http://127.0.0.1:3000"  --build-arg="OTLP_COLLECTOR_URL=http://127.0.0.1:4318" -t "$image_suffix"-frontend -f Frontend.dockerfile .

