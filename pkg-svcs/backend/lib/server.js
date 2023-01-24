'use strict'

const path = require('path')

const { migrateFunction } = require('../migrate')

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

  await server.ready()

  try {
    await migrateFunction(server.pg, JSON.parse(server.secrets.dbInfo))
  } catch (error) {
    console.log('Error when applying migrations: ', error)
    process.exit(1)
  }

  server.get('/', () => {
    return 'OK'
  })
}

module.exports = fp(plugin)
