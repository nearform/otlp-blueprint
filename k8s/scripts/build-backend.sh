set -e

image_suffix=${1:-$IMAGE_NAME}

cd ../
  docker build -t $image_suffix-backend -f Backend.dockerfile .
cd -
