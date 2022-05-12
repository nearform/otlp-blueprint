'use strict'

async function getAll(server) {
  server.route({
    method: 'GET',
    url: '/',
    schema: {
      tags: ['todo'],
      response: {
        200: {
          description: 'Successful response',
          type: 'array'
        }
      }
    },
    handler: async (request, reply) => {
      const postgresClient = request.server.pg

      const { rows } = await postgresClient.query('SELECT * FROM todo')
      reply.code(200).header('Content-Type', 'application/json; charset=utf-8')
      return rows
    }
  })
}

module.exports = getAll
