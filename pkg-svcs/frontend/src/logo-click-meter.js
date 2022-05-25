import { MeterProvider } from '@opentelemetry/sdk-metrics-base'
import { OTLPMetricExporter } from '@opentelemetry/exporter-metrics-otlp-http'

const createLogoClickCounter = options => {
  const collectorOptions = {
    url: options.collectorMetricsUrl,
    concurrencyLimit: 1
  }
  const exporter = new OTLPMetricExporter(collectorOptions)

  const meter = new MeterProvider({
    exporter,
    interval: 60000
  }).getMeter('frontend-meter')

  const counter = meter.createCounter('logo_clicks')
  return counter
}

export default createLogoClickCounter
