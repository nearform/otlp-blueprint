const { DiagConsoleLogger, DiagLogLevel, diag } = require('@opentelemetry/api')
const {
  OTLPMetricExporter
} = require('@opentelemetry/exporter-metrics-otlp-http')
const {
  MeterProvider,
  PeriodicExportingMetricReader
} = require('@opentelemetry/sdk-metrics')
const { Resource } = require('@opentelemetry/resources')
const {
  SemanticResourceAttributes
} = require('@opentelemetry/semantic-conventions')

const enableMonitoring = options => {
  diag.setLogger(
    new DiagConsoleLogger(),
    options.debug ? DiagLogLevel.DEBUG : DiagLogLevel.INFO
  )

  const metricExporter = new OTLPMetricExporter({
    url: `${options.collectorUrl}/v1/metrics`,
    serviceName: options.serviceName,
    concurrencyLimit: 10
  })

  const meterProvider = new MeterProvider({
    resource: new Resource({
      [SemanticResourceAttributes.SERVICE_NAME]: 'basic-metric-service'
    })
  })

  meterProvider.addMetricReader(
    new PeriodicExportingMetricReader({
      exporter: metricExporter,
      exportIntervalMillis: 1000
    })
  )

  // Meter definitions
  const meter = meterProvider.getMeter('metrics-collector')

  // Platform metrics
  const requestCounter = meter.createCounter('http.server.requests', {
    description: 'Requests counter'
  })

  const activeRequests = meter.createUpDownCounter(
    'http.server.active_requests',
    {
      description: 'Monitor the active requests in the server'
    }
  )

  const requestTimes = meter.createHistogram('http.server.request.times', {
    description: 'Histogram showing the request times'
  })

  // Domain metrics
  const todoCounter = meter.createCounter('domain.todos', {
    description: 'Todos counter'
  })

  const activeTodos = meter.createUpDownCounter('domain.todos.active', {
    description: 'Monitor the active todos'
  })

  return {
    requestCounter,
    activeRequests,
    requestTimes,
    todoCounter,
    activeTodos
  }
}

module.exports = { enableMonitoring }
