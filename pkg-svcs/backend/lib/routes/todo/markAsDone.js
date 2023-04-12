'use strict'

async function insert(server) {
  server.route({
    method: 'POST',
    url: '/:id',
    schema: {
      params: {
        id: {
          type: 'number'
        }
      },
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

      await postgresClient.query(
        'UPDATE todo SET is_done=true WHERE todo_id=$1',
        [request.params.id]
      )
      // reduce the active todo gauge metric
      request.server.monitoring.activeTodos.add(-1)
      const { rows } = await postgresClient.query('SELECT * FROM todo')
      reply.code(200).header('Content-Type', 'application/json; charset=utf-8')
      return rows
    }
  })
}

module.exports = insert
