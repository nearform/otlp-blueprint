import React, { useState } from 'react'
import PropTypes from 'prop-types'

import './NewItem.css'

const NewItem = ({ onAdd }) => {
  const [value, setValue] = useState('')

  const handleSubmit = event => {
    if (event.key === 'Enter') {
      onAdd(event.target.value)
      setValue('')
    }
  }

  const handleChange = event => setValue(event.target.value)

  return (
    <div className="NewItem">
      <input
        type="text"
        className="NewItem-input"
        placeholder="What needs to be done?"
        onKeyPress={handleSubmit}
        onInput={handleChange}
        value={value}
      />
    </div>
  )
}

NewItem.propTypes = {
  onAdd: PropTypes.func
}

export default NewItem
