'use strict'

require('pg-range').install(require('pg'))
const fp = require('fastify-plugin')

async function plugin(server, options) {
  const dbInfo = JSON.parse(server.secrets.dbInfo)

  server.register(require('@fastify/postgres'), {
    ...options.pgPlugin,
    host: dbInfo.host,
    port: dbInfo.port,
    database: dbInfo.database,
    user: dbInfo.username,
    password: dbInfo.password
  })
}

module.exports = fp(plugin, {
  name: 'pg',
  dependencies: ['secrets-manager']
})
