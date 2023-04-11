const fp = require('fastify-plugin')

async function plugin(server, options) {
    server.addHook('onRequest', (req, res, done) => {
        const { method, protocol: scheme, routerPath } = req
        server.monitoring.requestCounter.add(1, { path: routerPath })
        server.monitoring.activeRequests.add(1, { method, scheme })
        //Timeout helps to keep this request
        // setTimeout(() => {
        //     done()
        // }, 10000)
        done()
    })
    server.addHook('onResponse', (req, _res, done) => {
        const { method, protocol: scheme } = req
        server.monitoring.activeRequests.add(-1, { method, scheme })
        done()
    })
}

module.exports = fp(plugin, {
    name: 'otlp-metrics',
})
