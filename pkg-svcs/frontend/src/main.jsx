import React from 'react'
import ReactDOM from 'react-dom/client'
import App from './App'

import enableTracing from './tracing'

import './index.css'

const tracer = enableTracing({
  collectorUrl: import.meta.env.VITE_OTLP_COLLECTOR_URL,
  serviceName: import.meta.env.VITE_OTLP_SERVICE_NAME,
  enableConsoleLog: import.meta.env.VITE_OTLP_ENABLE_CONSOLE_LOG,
  environment: import.meta.env.VITE_OTLP_ENVIRONMENT
})

// custom span example
const span = tracer.startSpan('custom-span')
setTimeout(() => {
  span.end()
}, 3000)

ReactDOM.createRoot(document.getElementById('root')).render(
  <React.StrictMode>
    <App />
  </React.StrictMode>
)
