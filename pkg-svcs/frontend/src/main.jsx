import React from 'react'
import ReactDOM from 'react-dom/client'
import App from './App'

import enableTracing from './tracing'

import './index.css'

enableTracing({
  collectorUrl: import.meta.env.VITE_OTLP_COLLECTOR_URL,
  serviceName: import.meta.env.VITE_OTLP_SERVICE_NAME,
  enableConsoleLog: import.meta.env.VITE_OTLP_ENABLE_CONSOLE_LOG
})

ReactDOM.createRoot(document.getElementById('root')).render(
  <React.StrictMode>
    <App />
  </React.StrictMode>
)
