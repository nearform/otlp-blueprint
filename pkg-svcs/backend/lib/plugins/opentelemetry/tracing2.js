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
diag.setLogger(new DiagConsoleLogger(), DiagLogLevel.DEBUG)

const hostName = process.env.OTEL_TRACE_HOST || '0.0.0.0'

const options = {
  tags: [],
  // Use host name as `jaeger` in case of running locally using docker-compose. We need a better way of configuring this from  a config file.  
  endpoint: `http://jaeger:14268/api/traces`
  // Uncomment below setting for UDP setup
  // host: '0.0.0.0', 
  // port: 6831
}

const init = (serviceName, environment) => {
  const exporter = new JaegerExporter(options)

  const provider = new NodeTracerProvider({
    resource: new Resource({
      [SemanticResourceAttributes.SERVICE_NAME]: serviceName,
      [SemanticResourceAttributes.DEPLOYMENT_ENVIRONMENT]: environment
    })
  })

  provider.addSpanProcessor(new BatchSpanProcessor(exporter))
  provider.addSpanProcessor(new SimpleSpanProcessor(new ConsoleSpanExporter()))
  provider.register({ propagator: new OTTracePropagator() })

  registerInstrumentations({
    instrumentations: [
      getNodeAutoInstrumentations(),
      new FastifyInstrumentation()
    ]
  })

  const tracer = provider.getTracer(serviceName)
  return { tracer }
}

module.exports = {
  init: init
}
