const { Resource } = require('@opentelemetry/resources')
const {
  SemanticResourceAttributes
} = require('@opentelemetry/semantic-conventions')
const { NodeTracerProvider } = require('@opentelemetry/sdk-trace-node')
const { registerInstrumentations } = require('@opentelemetry/instrumentation')
const {
  ConsoleSpanExporter,
  BatchSpanProcessor,
  SimpleSpanProcessor
} = require('@opentelemetry/sdk-trace-base')
const { OTLPTraceExporter } = require('@opentelemetry/exporter-trace-otlp-http')
const {
  getNodeAutoInstrumentations
} = require('@opentelemetry/auto-instrumentations-node')
const { diag, DiagConsoleLogger, DiagLogLevel } = require('@opentelemetry/api')

registerInstrumentations({
  instrumentations: [
    getNodeAutoInstrumentations({
      '@opentelemetry/instrumentation-fs': { enabled: false }
    })
  ]
})

const enableTracing = options => {
  diag.setLogger(
    new DiagConsoleLogger(),
    options.debug ? DiagLogLevel.DEBUG : DiagLogLevel.INFO
  )

  const resource = Resource.default().merge(
    new Resource({
      [SemanticResourceAttributes.SERVICE_NAME]: options.serviceName,
      [SemanticResourceAttributes.SERVICE_VERSION]: '0.1.0'
    })
  )

  const provider = new NodeTracerProvider({
    resource: resource
  })
  console.log(`collector url: ${options.collectorUrl}/v1/traces`)
  const exporter = new OTLPTraceExporter({
    url: `${options.collectorUrl}/v1/traces`,
    serviceName: options.serviceName,
    concurrencyLimit: 10
  })
  const processor = new BatchSpanProcessor(exporter)
  provider.addSpanProcessor(new SimpleSpanProcessor(new ConsoleSpanExporter()))
  provider.addSpanProcessor(processor)

  provider.register()

  const tracer = provider.getTracer(options.serviceName)
  return tracer
}

module.exports = {
  enableTracing
}
