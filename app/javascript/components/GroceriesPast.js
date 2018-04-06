import React from 'react'
import PropTypes from 'prop-types'

import Document from './Document'
import SuperHeading from './SuperHeading'
import GroceriesList from './GroceriesList'

const GroceriesPast = ({ groceries }) => (
  <Document mw={6}>
    <SuperHeading className="f2 f2-ns mvn-ns">
      Past grocery list items
    </SuperHeading>
    <GroceriesList items={groceries} showCompleted />
  </Document>
)

GroceriesPast.propTypes = {
  groceries: PropTypes.array.isRequired
}

export default GroceriesPast
