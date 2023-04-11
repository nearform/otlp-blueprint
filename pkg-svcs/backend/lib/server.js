'use strict'

const path = require('path')

const autoload = require('@fastify/autoload')
const fp = require('fastify-plugin')
const monitoring = require('./monitoring')

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

  server.get('/', async (_, res) => {
    monitoring.requestCounter.add(1, { env: 'staging' })
    return 'ok'
  })
}

module.exports = fp(plugin)
