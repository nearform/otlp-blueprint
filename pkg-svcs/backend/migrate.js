#! /usr/bin/env node

'use strict'

const path = require('path')

async function migrateFunction(server) {
  const { default: Postgrator } = await import('postgrator')

  const postgrator = new Postgrator({
    migrationPattern: path.join(__dirname, '/migrations/*'),
    driver: 'pg',
    database: server.secrets.dbInfo.database,
    schemaTable: 'migrations',
    currentSchema: 'public',
    execQuery: query => server.pg.query(query)
  })

  const result = await postgrator.migrate()

  if (result.length === 0) {
    console.log(
      'No migrations run for schema "public". Already at the latest one.'
    )
  }

  console.log('Migration one.')
}

module.exports = {
  migrateFunction
}
