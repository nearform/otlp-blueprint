'use strict'
import { build } from './app.mjs'

const server = build({
  logger: {
    level: 'info',
    prettyPrint: true
  }
})

server.listen(3000, '0.0.0.0', (err, address) => {
  if (err) {
    server.log.error(err)
    process.exit(1)
  }
})