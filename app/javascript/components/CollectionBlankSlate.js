import React from 'react'
import PropTypes from 'prop-types'

import BlankSlate from './BlankSlate'
import Button from './Button'
import Spacer from './Spacer'

const heading = <h3 className="mvn">No recipes in this collection yet.</h3>

const CollectionBlankSlate = ({ id, pub = true }) =>
  pub ? (
    <BlankSlate className="bg-white" margin="mtn" children={heading} />
  ) : (
      <BlankSlate className="bg-white" margin="mtn">
        {heading}
        <p className="mvm">
          Create a new recipe, or add an existing one from its page.
      </p>
        <footer className="flex fjc">
          <Button
            color="blue"
            href={`/recipes/new?collection=${id}`}
            children="New recipe"
          />
          <Spacer x={16} />
          <Button href="/recipes" color="grey-3" children="Find a recipe" />
        </footer>
      </BlankSlate>
    )

CollectionBlankSlate.propTypes = {
  id: PropTypes.number.isRequired,
  pub: PropTypes.bool
}

export default CollectionBlankSlate
