import React from 'react'
import PropTypes from 'prop-types'

import './TodoItem.css'

const TodoItem = ({ item, onDone }) => (
  <div className="TodoItem">
    <input
      type="checkbox"
      className="TodoItem-checkbox"
      onClick={() => onDone(item.todo_id)}
    />
    <span>{item.title}</span>
  </div>
)

TodoItem.propTypes = {
  item: PropTypes.shape({
    todo_id: PropTypes.number,
    title: PropTypes.string
  }),
  onDone: PropTypes.func
}

export default TodoItem
