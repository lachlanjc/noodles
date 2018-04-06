import React from 'react'
import Document from './Document'
import SuperHeader from './SuperHeader'
import GroceriesForm from './GroceriesForm'

const GroceriesNew = () => (
  <Document mw={6}>
    <SuperHeader className="f2 f2-ns mvn-ns">Add grocery item</SuperHeader>
    <GroceriesForm style={{ marginTop: '1rem' }} />
  </Document>
)

export default GroceriesNew
