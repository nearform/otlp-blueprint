'use strict'

const opentelemetry = require('@opentelemetry/sdk-node')
const {
  getNodeAutoInstrumentations
} = require('@opentelemetry/auto-instrumentations-node')
const {
  FastifyInstrumentation
} = require('@opentelemetry/instrumentation-fastify')
const { JaegerExporter } = require('@opentelemetry/exporter-jaeger')
const { Resource } = require('@opentelemetry/resources')
const {
  SemanticResourceAttributes
} = require('@opentelemetry/semantic-conventions')

// For troubleshooting, set the log level to DiagLogLevel.DEBUG
const { diag, DiagConsoleLogger, DiagLogLevel } = require('@opentelemetry/api')
diag.setLogger(new DiagConsoleLogger(), DiagLogLevel.DEBUG)

const jaegerExporter = new JaegerExporter({
  host: 'localhost',
  port: 6831
})

const sdk = new opentelemetry.NodeSDK({
  resource: new Resource({
    [SemanticResourceAttributes.SERVICE_NAME]: 'demo-otlp-service'
  }),
  traceExporter: jaegerExporter, // new opentelemetry.tracing.ConsoleSpanExporter(),
  instrumentations: [
    getNodeAutoInstrumentations(),
    new FastifyInstrumentation()
  ]
})

module.exports = {
  sdk
}
