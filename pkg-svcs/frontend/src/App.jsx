import React from 'react'
import TodoApp from './components/TodoApp'
// import createLogoClickCounter from './logo-click-meter'

import './App.css'

// const logoClickCounter = createLogoClickCounter({
//   collectorMetricsUrl: import.meta.env.VITE_OTLP_COLLECTOR_METRICS_URL
// })

function App() {
  return (
    <div className="App">
      <header className="App-header">
        <span onClick={() => {} /*logoClickCounter.add(1)*/}>
          Yet Another Todo App
        </span>
      </header>
      <div className="App-content">
        <TodoApp />
      </div>
    </div>
  )
}

export default App
