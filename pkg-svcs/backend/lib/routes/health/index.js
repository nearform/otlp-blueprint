'use strict'

async function health(server) {
  server.route({
    method: 'GET',
    url: '/',
    schema: {
      response: {
        200: {
          description: 'Successful response',
          type: 'string'
        }
      }
    },
    handler: async () => {
      return 'OK'
    }
  })
}

module.exports = health
