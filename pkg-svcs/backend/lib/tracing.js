'use strict'

const {  ConsoleSpanExporter,  SimpleSpanProcessor,  BatchSpanProcessor} = require('@opentelemetry/sdk-trace-base')

const { Resource } = require('@opentelemetry/resources')

const {  SemanticResourceAttributes} = require('@opentelemetry/semantic-conventions')

const { registerInstrumentations } = require('@opentelemetry/instrumentation')
const {  getNodeAutoInstrumentations} = require('@opentelemetry/auto-instrumentations-node')

const { OTLPTraceExporter } = require('@opentelemetry/exporter-trace-otlp-http')
const { NodeTracerProvider } = require('@opentelemetry/sdk-trace-node')

const { diag, DiagConsoleLogger, DiagLogLevel } = require('@opentelemetry/api')

const enableTracing = options => {
  diag.setLogger(
    new DiagConsoleLogger(),
    options.debug ? DiagLogLevel.DEBUG : DiagLogLevel.INFO
  )

  const exporter = new OTLPTraceExporter({
    url: options.collectorTracesUrl,
    serviceName: options.serviceName,
    concurrencyLimit: 10
  })

  const provider = new NodeTracerProvider({
    resource: new Resource({
      [SemanticResourceAttributes.SERVICE_NAME]: options.serviceName,
      [SemanticResourceAttributes.DEPLOYMENT_ENVIRONMENT]: options.environment
    })
  })

  provider.addSpanProcessor(new BatchSpanProcessor(exporter))

  if (options.enableConsoleLog) {
    provider.addSpanProcessor(
      new SimpleSpanProcessor(new ConsoleSpanExporter())
    )
  }


  registerInstrumentations({
    instrumentations: [getNodeAutoInstrumentations()]
  })

  const tracer = provider.getTracer(options.serviceName)
  return tracer
}

module.exports = {
  enableTracing
}
