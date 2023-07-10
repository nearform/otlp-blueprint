FROM otel/opentelemetry-collector:0.56.0

COPY collector-config.yaml /etc/otel-collector-config.yaml
