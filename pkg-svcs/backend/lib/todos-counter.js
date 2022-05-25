const { MeterProvider } = require('@opentelemetry/sdk-metrics-base')
const {
  OTLPMetricExporter
} = require('@opentelemetry/exporter-metrics-otlp-http')

const createTodoCounter = options => {
  const meter = new MeterProvider({
    exporter: new OTLPMetricExporter({
      url: options.collectorMetricsUrl,
      concurrencyLimit: 1
    })
  }).getMeter('backend_meter')

  const counter = meter.createCounter('todos_created', {
    description: 'How many todos have been created'
  })

  return counter
}

module.exports = createTodoCounter
