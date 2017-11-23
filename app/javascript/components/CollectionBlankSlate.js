import React from 'react'
import PropTypes from 'prop-types'

import BlankSlate from './BlankSlate'
import Button from './Button'
import Spacer from './Spacer'

const CollectionBlankSlate = ({ id, pub = true }) => (
  <BlankSlate className="bg-white" margin="mvn mln">
    <h3 className="mvn">No recipes in this collection yet.</h3>
    {!pub && [
      <p className="mvm" key="desc">
        Add an existing recipe from its page, or create a new one.
      </p>,
      <footer className="flex fjc" key="footer">
        <Button
          color="blue"
          href={`/recipes/new?collection=${id}`}
          children="New recipe"
        />
        <Spacer x={16} />
        <Button href="/recipes" color="grey-3" children="Find a recipe" />
      </footer>
    ]}
  </BlankSlate>
)

CollectionBlankSlate.propTypes = {
  id: PropTypes.number.isRequired,
  pub: PropTypes.bool
}

export default CollectionBlankSlate
