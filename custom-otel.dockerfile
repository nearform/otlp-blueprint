# Start from the OpenTelemetry Collector image
FROM otel/opentelemetry-collector:latest

# Set the working directory
WORKDIR /conf

# Copy your local configuration file into the Docker container
COPY ./collector-config.yaml /conf/collector-config.yaml

# Run the collector with the custom config file
CMD ["/otelcol", "--config=/conf/collector-config.yaml"]