'use strict'

const fp = require('fastify-plugin')

// const { sdk } = require('./tracing')
const { init } = require('./tracing2')

async function plugin() {
  // sdk.start()
  init('demo-node-service', 'development')
}

module.exports = fp(plugin, {
  name: 'opentelemetry'
})
