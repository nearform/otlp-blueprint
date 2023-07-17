set -e

pushd ../../
  docker build --build-arg="API_URL=http://127.0.0.1:3000"  --build-arg="OTLP_COLLECTOR_URL=http://127.0.0.1:4318" -t otlp-blueprint-frontend -f Frontend.dockerfile .
popd
