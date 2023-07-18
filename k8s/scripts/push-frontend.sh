set -e

registry=$1
image_suffix="${2:-"otlp-blueprint"}"

docker tag "$image_suffix"-backend:latest "$registry"/"$image_suffix"-frontend:latest
docker push "$registry"/"$image_suffix"-frontend:latest
