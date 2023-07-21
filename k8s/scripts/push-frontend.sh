set -e

registry=$1
image_suffix="${2:-IMAGE_NAME}"

docker tag "$image_suffix"-frontend:latest "$registry"/"$image_suffix"-frontend:latest
docker push "$registry"/"$image_suffix"-frontend:latest
