// ESM
import Fastify from 'fastify'
import fastifyCors from '@fastify/cors'

import Todos from './Todos.mjs'

function build(opts = {}) {
  const app = Fastify(opts)

  app.register(fastifyCors, {
    origin: '*',
    methods: ['POST']
  })

  const todos = new Todos()

  app.get('/todo', async function (request, reply) {
    const allTodos = await todos.getAll()
    reply.header('Access-Control-Allow-Origin', '*').code(200).send(allTodos)
  })

  app.post('/todo', async function (request, reply) {
    const newState = await todos.insert(request.body.title)
    reply.header('Access-Control-Allow-Origin', '*').code(200).send(newState)
  })

  app.post('/todo/:id', async function (request, reply) {
    const newState = await todos.markAsDone(request.params.id)
    reply.header('Access-Control-Allow-Origin', '*').code(200).send(newState)
  })

  app.get('/status', async function (request, reply) {
    reply.header('Access-Control-Allow-Origin', '*').code(200).send()
  })

  return app
}

export { build }
