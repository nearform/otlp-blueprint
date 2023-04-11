'use strict';

const { DiagConsoleLogger, DiagLogLevel, diag } = require('@opentelemetry/api');
const { OTLPMetricExporter } = require('@opentelemetry/exporter-metrics-otlp-http');
const { MeterProvider, PeriodicExportingMetricReader } = require('@opentelemetry/sdk-metrics');
const { Resource } = require('@opentelemetry/resources');
const { SemanticResourceAttributes } = require('@opentelemetry/semantic-conventions');

const options = { debug: DiagLogLevel.DEBUG, collectorUrl: 'http://collector:4318' }


diag.setLogger(
    new DiagConsoleLogger(),
    options.debug ? DiagLogLevel.DEBUG : DiagLogLevel.INFO
)

const metricExporter = new OTLPMetricExporter({
    url: `${options.collectorUrl}/v1/metrics`,
    serviceName: options.serviceName,
    concurrencyLimit: 10
});

const meterProvider = new MeterProvider({
    resource: new Resource({
        [SemanticResourceAttributes.SERVICE_NAME]: 'basic-metric-service',
    }),
});

meterProvider.addMetricReader(new PeriodicExportingMetricReader({
    exporter: metricExporter,
    exportIntervalMillis: 1000,
}));

const meter = meterProvider.getMeter('example-exporter-collector');

const requestCounter = meter.createCounter('requests', {
    description: 'Example of a Counter',
});

// const upDownCounter = meter.createUpDownCounter('test_up_down_counter', {
//     description: 'Example of a UpDownCounter',
// });

// const histogram = meter.createHistogram('test_histogram', {
//     description: 'Example of a Histogram',
// });

// const attributes = { pid: process.pid, environment: 'staging' };

module.exports = { requestCounter }
// setInterval(() => {
//     requestCounter.add(1, attributes);
//     upDownCounter.add(Math.random() > 0.5 ? 1 : -1, attributes);
//     histogram.record(Math.random(), attributes);
// }, 1000);