import {
  ConsoleSpanExporter,
  SimpleSpanProcessor,
  BatchSpanProcessor
} from '@opentelemetry/sdk-trace-base'
import { WebTracerProvider } from '@opentelemetry/sdk-trace-web'
import { DocumentLoadInstrumentation } from '@opentelemetry/instrumentation-document-load'
import { XMLHttpRequestInstrumentation } from '@opentelemetry/instrumentation-xml-http-request'
import { UserInteractionInstrumentation } from '@opentelemetry/instrumentation-user-interaction'
import { ZoneContextManager } from '@opentelemetry/context-zone'
import { OTLPTraceExporter } from '@opentelemetry/exporter-otlp-http'
import { B3Propagator } from '@opentelemetry/propagator-b3'
import {
  CompositePropagator,
  W3CTraceContextPropagator
} from '@opentelemetry/core'
import { registerInstrumentations } from '@opentelemetry/instrumentation'
import { Resource } from '@opentelemetry/resources'
import { SemanticResourceAttributes } from '@opentelemetry/semantic-conventions'

const enableTracing = options => {
  const exporter = new OTLPTraceExporter({
    url: options.collectorUrl,
    serviceName: options.serviceName,
    concurrencyLimit: 10
  })

  const provider = new WebTracerProvider({
    resource: new Resource({
      [SemanticResourceAttributes.SERVICE_NAME]: options.serviceName,
      [SemanticResourceAttributes.DEPLOYMENT_ENVIRONMENT]: options.environment
    })
  })

  if (options.enableConsoleLog) {
    provider.addSpanProcessor(
      new SimpleSpanProcessor(new ConsoleSpanExporter())
    )
  }

  provider.addSpanProcessor(
    new BatchSpanProcessor(exporter, {
      maxQueueSize: 100,
      maxExportBatchSize: 10,
      scheduledDelayMillis: 500,
      exportTimeoutMillis: 30000
    })
  )

  provider.register({
    contextManager: new ZoneContextManager(),
    propagator: new CompositePropagator({
      propagators: [new B3Propagator(), new W3CTraceContextPropagator()]
    })
  })

  registerInstrumentations({
    instrumentations: [
      new DocumentLoadInstrumentation(),
      new XMLHttpRequestInstrumentation(),
      new UserInteractionInstrumentation()
    ],
    tracerProvider: provider
  })

  const tracer = provider.getTracer('example-document-load')
  return tracer
}

export default enableTracing
