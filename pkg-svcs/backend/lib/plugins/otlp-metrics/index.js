const fp = require('fastify-plugin')
const { enableMonitoring } = require('./setup')

async function plugin(server, options) {
  const hostname = require('os').hostname()
  const monitoring = enableMonitoring(options.otlp)

  server.decorate('monitoring', monitoring)

  server.addHook('onRequest', (req, _res, done) => {
    const [{ port }] = server.addresses()
    const { method, protocol: scheme, routerPath } = req
    monitoring.requestCounter.add(1, {
      path: routerPath,
      method,
      scheme,
      'net.host.name': hostname,
      'net.host.port': port
    })
    monitoring.activeRequests.add(1, {
      method,
      scheme,
      'net.host.name': hostname,
      'net.host.port': port
    })
    done()
  })

  server.addHook('onResponse', (req, res, done) => {
    const { method, protocol: scheme, routerPath } = req
    const [{ port }] = server.addresses()
    monitoring.activeRequests.add(-1, {
      method,
      scheme,
      'net.host.name': hostname,
      'net.host.port': port
    })
    monitoring.requestTimes.record(res.getResponseTime(), {
      path: routerPath,
      method,
      scheme,
      'net.host.name': hostname,
      'net.host.port': port
    })
    done()
  })
}

module.exports = fp(plugin, {
  name: 'otlp-metrics'
})
