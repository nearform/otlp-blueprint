import Pg from 'pg'

const query = callback => {
  return new Promise((resolve, reject) => {
    const pool = new Pg.Pool({
      host: process.env.POSTGRES_HOST,
      port: process.env.POSTGRES_PORT,
      user: process.env.POSTGRES_USER,
      password: process.env.POSTGRES_PASSWORD,
      database: process.env.POSTGRES_DATABASE
    })

    pool.connect(async (err, client, done) => {
      if (err) {
        console.error(err)
        reject(err)
      }

      const result = await callback(client, done)
      resolve(result)
    })
  })
}

class Todos {
  async getAll() {
    const result = await query(async (client, done) => {
      const queryResult = await client.query('SELECT * FROM todo')
      done()
      return queryResult.rows
    })

    return result
  }

  async insert(title) {
    const result = await query(async (client, done) => {
      await client.query('INSERT INTO todo (title) VALUES ($1)', [title])
      const queryResult = await client.query('SELECT * FROM todo')
      done()
      return queryResult.rows
    })

    return result
  }

  async markAsDone(todoId) {
    const result = await query(async (client, done) => {
      await client.query('UPDATE todo SET is_done=true WHERE todo_id=$1', [
        todoId
      ])
      const queryResult = await client.query('SELECT * FROM todo')
      done()
      return queryResult.rows
    })

    return result
  }
}

export default Todos
