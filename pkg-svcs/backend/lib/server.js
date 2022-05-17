'use strict'

const path = require('path')

const autoload = require('@fastify/autoload')
const fp = require('fastify-plugin')
// Need to initialise the tracer before starting the app.
const tracer = require('./plugins/opentelemetry/tracing2')
tracer.init('OLTP','Dev')

async function plugin(server, config) {
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
