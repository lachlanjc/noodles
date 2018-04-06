import React from 'react'
import Document from './Document'
import SuperHeading from './SuperHeading'
import GroceriesForm from './GroceriesForm'

const GroceriesNew = () => (
  <Document mw={6}>
    <SuperHeading className="f2 f2-ns mvn-ns">Add grocery item</SuperHeading>
    <GroceriesForm style={{ marginTop: '1rem' }} />
  </Document>
)

export default GroceriesNew
