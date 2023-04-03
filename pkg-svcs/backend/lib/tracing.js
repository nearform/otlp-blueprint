// 'use strict'

// const {
//   ConsoleSpanExporter,
//   SimpleSpanProcessor,
//   BatchSpanProcessor
// } = require('@opentelemetry/tracing')
// const { Resource } = require('@opentelemetry/resources')
// const {
//   SemanticResourceAttributes
// } = require('@opentelemetry/semantic-conventions')
// const { registerInstrumentations } = require('@opentelemetry/instrumentation')
// const {
//   getNodeAutoInstrumentations
// } = require('@opentelemetry/auto-instrumentations-node')
// const { OTLPTraceExporter } = require('@opentelemetry/exporter-otlp-http')
// const { NodeTracerProvider } = require('@opentelemetry/sdk-trace-node')
// const { OTTracePropagator } = require('@opentelemetry/propagator-ot-trace')

// const { diag, DiagConsoleLogger, DiagLogLevel } = require('@opentelemetry/api')

// const enableTracing = options => {
//   diag.setLogger(
//     new DiagConsoleLogger(),
//     options.debug ? DiagLogLevel.DEBUG : DiagLogLevel.INFO
//   )

//   const exporter = new OTLPTraceExporter({
//     url: options.collectorUrl,
//     serviceName: options.serviceName,
//     concurrencyLimit: 10
//   })

//   const provider = new NodeTracerProvider({
//     resource: new Resource({
//       [SemanticResourceAttributes.SERVICE_NAME]: options.serviceName,
//       [SemanticResourceAttributes.DEPLOYMENT_ENVIRONMENT]: options.environment
//     })
//   })

//   provider.addSpanProcessor(new BatchSpanProcessor(exporter))

//   if (options.enableConsoleLog) {
//     provider.addSpanProcessor(
//       new SimpleSpanProcessor(new ConsoleSpanExporter())
//     )
//   }
//   registerInstrumentations({
//     instrumentations: [getNodeAutoInstrumentations()]
//   })

//   const tracer = provider.getTracer(options.serviceName)
//   return tracer
// }

// module.exports = {
//   enableTracing
// }
'use strict'
const process = require('process')
const opentelemetry = require('@opentelemetry/sdk-node')
const {
  getNodeAutoInstrumentations
} = require('@opentelemetry/auto-instrumentations-node')
const { Resource } = require('@opentelemetry/resources')
const { OTLPTraceExporter } = require('@opentelemetry/exporter-trace-otlp-http')

const traceExporter = new OTLPTraceExporter({
  url: options.collectorUrl,
  serviceName: options.serviceName,
  concurrencyLimit: 10
})
const sdk = new opentelemetry.NodeSDK({
  resource: new Resource(),
  traceExporter,
  instrumentations: [getNodeAutoInstrumentations()]
})
// initialize the SDK and register with the OpenTelemetry API
// this enables the API to record telemetry
sdk
  .start()
  .then(() => console.log('Auto instrumented tracing initialized'))
  .catch(error => console.log('Error initializing tracing', error))

// gracefully shut down the SDK on process exit
process.on('SIGTERM', () => {
  sdk
    .shutdown()
    .then(() => console.log('Tracing terminated'))
    .catch(error => console.log('Error terminating tracing', error))
    .finally(() => process.exit(0))
})