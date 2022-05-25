const envSchema = require('env-schema')
const S = require('fluent-json-schema')

const config = envSchema({
  dotenv: true,
  schema: S.object()
    .prop('NODE_ENV', S.string().required())
    .prop('API_HOST', S.string().required())
    .prop('API_PORT', S.string().required())
    .prop('CORS_ORIGIN', S.string())
    .prop('PG_HOST', S.string().required())
    .prop('PG_PORT', S.string().required())
    .prop('PG_DB', S.string().required())
    .prop('PG_USER', S.string().required())
    .prop('SECRETS_STRATEGY', S.string())
    .prop('SECRETS_PG_PASS', S.string().required())
    .prop('OTLP_DEBUG', S.string())
    .prop('OTLP_SERVICE_NAME', S.string())
    .prop('OTLP_ENVIRONMENT', S.string())
    .prop('OLTP_ENABLE_CONSOLE_LOG', S.string())
    .prop('OLTP_COLLECTOR_TRACES_URL', S.string())
    .prop('OLTP_COLLECTOR_METRICS_URL', S.string())
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
    host: config.PG_HOST,
    port: config.PG_PORT,
    database: config.PG_DB,
    user: config.PG_USER,
    poolSize: 10,
    idleTimeoutMillis: 30000
  },
  cors: { origin: !!config.CORS_ORIGIN, credentials: true },
  secretsManager: {
    strategy: config.SECRETS_STRATEGY,
    secrets: {
      dbPassword: config.SECRETS_PG_PASS
    }
  },
  otlp: {
    debug: config.OTLP_DEBUG === 'true',
    serviceName: config.OTLP_SERVICE_NAME,
    environment: config.OTLP_ENVIRONMENT,
    enableConsoleLog: config.OLTP_ENABLE_CONSOLE_LOG === 'true',
    collectorTracesUrl: config.OLTP_COLLECTOR_TRACES_URL,
    collectorMetricsUrl: config.OLTP_COLLECTOR_METRICS_URL
  }
}
