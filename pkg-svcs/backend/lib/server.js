'use strict'

const path = require('path')

const autoload = require('@fastify/autoload')
const fp = require('fastify-plugin')

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

  server.get('/', () => {
    return 'OK'
  })
}

module.exports = fp(plugin)
