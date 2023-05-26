import React, { useState, useEffect } from 'react'
import NewItem from '../NewItem'
import TodoList from '../TodoList'

const API_BASE_URL = "https://34.111.15.51.nip.io/"

const preparePostRequest = data => ({
  method: 'POST',
  body: JSON.stringify(data),
  headers: {
    'Content-Type': 'application/json'
  }
})

const TodoApp = () => {
  const [todos, setTodos] = useState([])

  useEffect(() => {
    fetch(`${API_BASE_URL}/todo`)
      .then(response => response.json())
      .then(initialState => {
        setTodos(initialState)
      })
  }, [])

  const handleNewItem = async title => {
    const response = await fetch(
      `${API_BASE_URL}/todo`,
      preparePostRequest({ title })
    )

    const updatedState = await response.json()
    setTodos(updatedState)
  }

  const handleRemoveItem = async id => {
    const response = await fetch(
      `${API_BASE_URL}/todo/${id}`,
      preparePostRequest({ is_done: true })
    )

    const updatedState = await response.json()
    setTodos(updatedState)
  }

  return (
    <div>
      <NewItem onAdd={handleNewItem} />
      <TodoList
        items={todos.filter(todo => !todo.is_done)}
        onDone={handleRemoveItem}
      />
    </div>
  )
}

export default TodoApp
