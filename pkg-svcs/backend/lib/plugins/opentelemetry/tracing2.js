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
const { HttpInstrumentation } = require('@opentelemetry/instrumentation-http')
const { registerInstrumentations } = require('@opentelemetry/instrumentation')
const { JaegerExporter } = require('@opentelemetry/exporter-jaeger')
const { NodeTracerProvider } = require('@opentelemetry/sdk-trace-node')
const { OTTracePropagator } = require('@opentelemetry/propagator-ot-trace')

const hostName = process.env.OTEL_TRACE_HOST || '0.0.0.0'

const options = {
  tags: [],
  endpoint: `http://${hostName}:14268/api/traces`
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
    instrumentations: [new FastifyInstrumentation(), new HttpInstrumentation()]
  })

  const tracer = provider.getTracer(serviceName)
  return { tracer }
}

module.exports = {
  init: init
}
