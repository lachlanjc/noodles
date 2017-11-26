import React from 'react'
import PropTypes from 'prop-types'

import GroceriesCheckbox from './GroceriesCheckbox'

const GroceriesListItem = ({ name, id, completedAt }) => (
  <li className="mts">
    <GroceriesCheckbox name={name} id={id} completedAt={completedAt} />
  </li>
)

GroceriesListItem.propTypes = {
  name: PropTypes.string.isRequired,
  id: PropTypes.number.isRequired,
  completedAt: PropTypes.string
}

export default GroceriesListItem
