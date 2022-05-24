'use strict'

const path = require('path')

const autoload = require('@fastify/autoload')
const fp = require('fastify-plugin')

const { enableTracing } = require('./tracing')

async function plugin(server, config) {
  const tracer = enableTracing(config.otlp)

  // custom span example
  const span = tracer.startSpan('custom-span')
  setTimeout(() => {
    span.end()
  }, 3000)

  server
    .register(require('@fastify/cors'), config.cors)
    .register(autoload, {
      dir: path.join(__dirname, 'plugins'),
      options: config
    })
    .register(autoload, {
      dir: path.join(__dirname, 'routes'),
      options: config
    })
}

module.exports = fp(plugin)
