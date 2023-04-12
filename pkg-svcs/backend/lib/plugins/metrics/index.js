const fp = require('fastify-plugin')
async function plugin(server, options) {
    const hostname = require('os').hostname()

    server.addHook('onRequest', (req, _res, done) => {
        console.log(options)
        const [{ port }] = server.addresses()
        const { method, protocol: scheme, routerPath } = req
        server.monitoring.requestCounter.add(1, { path: routerPath, method, scheme, 'net.host.name': hostname, 'net.host.port': port })
        server.monitoring.activeRequests.add(1, { method, scheme, 'net.host.name': hostname, 'net.host.port': port })
        done()
    })
    server.addHook('onResponse', (req, _res, done) => {
        const { method, protocol: scheme } = req
        const [{ port }] = server.addresses()
        server.monitoring.activeRequests.add(-1, { method, scheme, 'net.host.name': hostname, 'net.host.port': port })
        done()
    })
}

module.exports = fp(plugin, {
    name: 'otlp-metrics',
})
