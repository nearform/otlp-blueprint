import React, { useState } from 'react'
import TodoList from './components/TodoList'
import NewItem from './components/NewItem'

import './App.css'

function App() {
  const [todos, setTodos] = useState([])

  const addNewItem = thing =>
    setTodos([...todos, { id: todos.length + 1, description: thing }])

  const removeItem = id => setTodos(todos.filter(item => item.id !== id))

  return (
    <div className="App">
      <header className="App-header">Yet Another Todo App</header>
      <div className="App-content">
        <NewItem onAdd={addNewItem} />
        <TodoList items={todos} onDone={removeItem} />
      </div>
    </div>
  )
}

export default App
