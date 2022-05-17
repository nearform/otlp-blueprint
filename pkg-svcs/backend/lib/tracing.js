'use strict'

const {
  ConsoleSpanExporter,
  SimpleSpanProcessor,
  BatchSpanProcessor
} = require('@opentelemetry/tracing')
const { Resource } = require('@opentelemetry/resources')
const {
  SemanticResourceAttributes
} = require('@opentelemetry/semantic-conventions')
const {
  FastifyInstrumentation
} = require('@opentelemetry/instrumentation-fastify')
const { registerInstrumentations } = require('@opentelemetry/instrumentation')
const {
  getNodeAutoInstrumentations
} = require('@opentelemetry/auto-instrumentations-node')
const { JaegerExporter } = require('@opentelemetry/exporter-jaeger')
const { NodeTracerProvider } = require('@opentelemetry/sdk-trace-node')
const { OTTracePropagator } = require('@opentelemetry/propagator-ot-trace')

const { diag, DiagConsoleLogger, DiagLogLevel } = require('@opentelemetry/api')

const enableTracing = options => {
  diag.setLogger(
    new DiagConsoleLogger(),
    options.debug ? DiagLogLevel.DEBUG : DiagLogLevel.INFO
  )

  const exporter = new JaegerExporter({
    tags: [],
    endpoint: options.jaegerEndpoint
    // Uncomment below setting for UDP setup
    // host: '0.0.0.0',
    // port: 6831
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

  provider.register({ propagator: new OTTracePropagator() })

  registerInstrumentations({
    instrumentations: [
      getNodeAutoInstrumentations(),
      new FastifyInstrumentation()
    ]
  })

  const tracer = provider.getTracer(options.serviceName)
  return { tracer }
}

module.exports = {
  enableTracing
}
