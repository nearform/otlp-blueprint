import React from 'react'
import PropTypes from 'prop-types'
import TodoItem from '../TodoItem'

import './TodoList.css'

const TodoList = ({ items, onDone }) => (
  <div className="TodoList">
    {items.map(item => (
      <TodoItem item={item} key={`todo-item-${item.id}`} onDone={onDone} />
    ))}
  </div>
)

TodoList.propTypes = {
  items: PropTypes.arrayOf(PropTypes.shape({})),
  onDone: PropTypes.func
}

export default TodoList
