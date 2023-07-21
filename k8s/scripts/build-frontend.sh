#!/bin/bash

set -e

image_suffix=${1:-$IMAGE_NAME}
api_url=${2:-$API_URL}
otlp_collector_url=${3:-$OTLP_COLLECTOR_URL}

cd ../
  docker build --build-arg="API_URL=$api_url" --build-arg="OTLP_COLLECTOR_URL=$otlp_collector_url" -t ${image_suffix}-frontend -f Frontend.dockerfile .
cd -
