set -e

kind create cluster
kind load docker-image otlp-blueprint-frontend
kind load docker-image otlp-blueprint-backend


