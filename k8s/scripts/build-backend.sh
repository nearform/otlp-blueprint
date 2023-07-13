set -e

pushd ../
  docker build -t otlp-blueprint-backend -f Backend.dockerfile .
popd
