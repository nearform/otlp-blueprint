const { DiagConsoleLogger, DiagLogLevel, diag } = require('@opentelemetry/api');
const { OTLPMetricExporter } = require('@opentelemetry/exporter-metrics-otlp-http');
// const { OTLPMetricExporter } = require('@opentelemetry/exporter-metrics-otlp-grpc');
// const { OTLPMetricExporter } = require('@opentelemetry/exporter-metrics-otlp-proto');
const { MeterProvider, PeriodicExportingMetricReader } = require('@opentelemetry/sdk-metrics-base');
const { Resource } = require('@opentelemetry/resources');
const { SemanticResourceAttributes } = require('@opentelemetry/semantic-conventions');


const createTodoCounter = options => {
  // Optional and only needed to see the internal diagnostic logging (during development)
  diag.setLogger(new DiagConsoleLogger(), DiagLogLevel.DEBUG);

  const collectorOptions = {
    url: options.collectorMetricsUrl, // http://collector:55681/v1/metrics
    concurrencyLimit: 1, // an optional limit on pending requests
  };
  const metricExporter = new OTLPMetricExporter(collectorOptions);
  const meterProvider = new MeterProvider({
    resource: new Resource({
      [SemanticResourceAttributes.SERVICE_NAME]: 'basic-metric-service',
    }),
  });
  
  meterProvider.addMetricReader(new PeriodicExportingMetricReader({
    exporter: metricExporter,
    exportIntervalMillis: 1000,
  }));
  
  // Now, start recording data
  const meter = meterProvider.getMeter('example-meter');
  const counter = meter.createCounter('todos_created');
  counter.add(1, { "Test": "sdfsdfs" });

  return counter
}

module.exports = createTodoCounter
