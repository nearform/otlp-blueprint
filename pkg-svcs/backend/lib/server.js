'use strict'

const path = require('path')

const autoload = require('@fastify/autoload')
const fp = require('fastify-plugin')

const tracer = require('./tracing')

async function plugin(server, config) {
  tracer.enableTracing(config.otlp)

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
