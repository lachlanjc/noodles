import React from 'react'
import BlankSlate from './BlankSlate'
import GroceriesForm from './GroceriesForm'

const GroceriesBlankSlate = () => (
  <BlankSlate margin="mtm mbn">
    <h3 className="mvn">No groceries yet.</h3>
    <p className="mts mbn">
      Keep a list of all the groceries you need to buy here.
    </p>
    <GroceriesForm makeSuggestions />
  </BlankSlate>
)

export default GroceriesBlankSlate
