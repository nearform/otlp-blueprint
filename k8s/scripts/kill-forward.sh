set -e

pkill -f 3000:3000 || true
pkill -f 8080:8080 || true
pkill -f 4318:4318 || true
pkill -f 16686:16686 || true
pkill -f 8888:8888 || true
