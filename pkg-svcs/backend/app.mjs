// ESM
import Fastify from 'fastify'

function build(opts={}) {
  const app = Fastify(opts)
  app.get('/', async function (request, reply) {
    reply
    .header("Access-Control-Allow-Origin", "*")
    .code(200)
    .send({ hello: 'world is super' })
  })
  app.get('/status', async function (request, reply) {
    reply
    .header("Access-Control-Allow-Origin", "*")
    .code(200)
    .send()
  })

  return app
}

export {
  build
}