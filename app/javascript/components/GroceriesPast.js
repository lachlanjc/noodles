import React from 'react'
import PropTypes from 'prop-types'

import Document from './Document'
import SuperHeader from './SuperHeader'
import GroceriesList from './GroceriesList'

const GroceriesPast = ({ groceries }) => (
  <Document mw={6}>
    <SuperHeader className="sans f2 f2-ns mvn-ns">
      Past grocery lists
    </SuperHeader>
    <GroceriesList items={groceries} />
  </Document>
)

GroceriesPast.propTypes = {
  groceries: PropTypes.array.isRequired
}

export default GroceriesPast
