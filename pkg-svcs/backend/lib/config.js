const envSchema = require('env-schema')
const S = require('fluent-json-schema')

const config = envSchema({
  dotenv: true,
  schema: S.object()
    .prop('NODE_ENV', S.string().required())
    .prop('API_HOST', S.string().required())
    .prop('API_PORT', S.string().required())
    .prop('CORS_ORIGIN', S.string())
    .prop('SECRETS_STRATEGY', S.string())
    .prop('SECRETS_PG_INFO', S.string().required())
    .prop('OTLP_DEBUG', S.string())
    .prop('OTLP_SERVICE_NAME', S.string())
    .prop('OTLP_ENVIRONMENT', S.string())
    .prop('OLTP_ENABLE_CONSOLE_LOG', S.string())
    .prop('OLTP_COLLECTOR_URL', S.string())
})

module.exports = {
  isProduction: config.IS_PRODUCTION,
  server: {
    host: config.API_HOST,
    port: config.API_PORT
  },
  fastify: {
    logger: true
  },
  pgPlugin: {
    poolSize: 10,
    idleTimeoutMillis: 30000
  },
  cors: { origin: !!config.CORS_ORIGIN, credentials: true },
  secretsManager: {
    strategy: config.SECRETS_STRATEGY,
    secrets: {
      dbInfo: config.SECRETS_PG_INFO
    }
  },
  otlp: {
    debug: config.OTLP_DEBUG,
    serviceName: config.OTLP_SERVICE_NAME,
    environment: config.OTLP_ENVIRONMENT,
    enableConsoleLog: config.OLTP_ENABLE_CONSOLE_LOG,
    collectorUrl: config.OLTP_COLLECTOR_URL
  }
}
