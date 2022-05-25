'use strict'

const createTodoCounter = require('../../todos-counter')
const counter = createTodoCounter({
  collectorMetricsUrl: process.env.OLTP_COLLECTOR_METRICS_URL
})

async function insert(server) {
  server.route({
    method: 'POST',
    url: '/',
    schema: {
      body: {
        type: 'object',
        properties: {
          title: { type: 'string' }
        }
      },
      tags: ['todo'],
      response: {
        201: {
          description: 'Successful response',
          type: 'array'
        }
      }
    },
    handler: async (request, reply) => {
      const postgresClient = request.server.pg

      await postgresClient.query('INSERT INTO todo (title) VALUES ($1)', [
        request.body.title
      ])
      const { rows } = await postgresClient.query('SELECT * FROM todo')
      reply.code(200).header('Content-Type', 'application/json; charset=utf-8')

      counter.add(1, { pid: process.pid })

      return rows
    }
  })
}

module.exports = insert
