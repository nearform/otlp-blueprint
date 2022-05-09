import React, { useState } from 'react'
import NewItem from '../NewItem'
import TodoList from '../TodoList'

const TodoApp = () => {
  const [todos, setTodos] = useState([])

  const handleNewItem = thing =>
    setTodos([...todos, { id: todos.length + 1, description: thing }])

  const handleRemoveItem = id => setTodos(todos.filter(item => item.id !== id))

  return (
    <div>
      <NewItem onAdd={handleNewItem} />
      <TodoList items={todos} onDone={handleRemoveItem} />
    </div>
  )
}

export default TodoApp
