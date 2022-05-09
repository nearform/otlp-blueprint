// ESM
import Fastify from 'fastify'

function build(opts = {}) {
  const app = Fastify(opts)

  let todos = []

  app.get('/todo', async function (request, reply) {
    reply.header('Access-Control-Allow-Origin', '*').code(200).send(todos)
  })

  app.post('/todo', async function (request, reply) {
    const newTodo = {
      id: todos.length + 1,
      title: request.body.title,
      is_done: false
    }

    todos.push(newTodo)

    reply.header('Access-Control-Allow-Origin', '*').code(200).send(todos)
  })

  app.post('/todo/:id', async function (request, reply) {
    const todo = todos.find(item => item.id === parseInt(request.params.id))
    todo.is_done = request.body.is_done

    reply.header('Access-Control-Allow-Origin', '*').code(200).send(todos)
  })

  app.get('/status', async function (request, reply) {
    reply.header('Access-Control-Allow-Origin', '*').code(200).send()
  })

  return app
}

export { build }
