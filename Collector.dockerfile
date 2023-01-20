FROM otel/opentelemetry-collector:latest

COPY collector-config.yaml /etc/otel-collector-config.yaml
