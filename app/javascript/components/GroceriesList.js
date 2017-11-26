import React from 'react'
import PropTypes from 'prop-types'

import GroceriesCheckbox from './GroceriesCheckbox'

const GroceriesList = ({ items }) => (
  <ul
    className="list-reset mtm mbn"
    children={_.map(items, item => (
      <GroceriesCheckbox
        name={item.name}
        id={item.id}
        completedAt={item.completed_at}
        key={`item-${item.id}`}
      />
    ))}
  />
)

GroceriesList.propTypes = {
  items: PropTypes.array.isRequired
}

export default GroceriesList
