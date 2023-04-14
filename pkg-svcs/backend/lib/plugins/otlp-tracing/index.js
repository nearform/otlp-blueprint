const fp = require('fastify-plugin')
const { enableTracing } = require('./setup')

async function plugin(server, options) {
  const tracer = enableTracing(options.otlp)

  server.decorate('tracing', tracer)

  // custom span example
  const span = tracer.startSpan('custom-span')
  setTimeout(() => {
    span.end()
  }, 3000)
}

module.exports = fp(plugin, {
  name: 'otlp-tracing'
})
