import React from 'react'
import PropTypes from 'prop-types'

import Button from './Button'
import CollectionsMini from './CollectionsMini'
import ModalLink from './ModalLink'
import Spacer from './Spacer'

const RecipesHomeSidebar = ({
  collections = [],
  hideCollections = false,
  ...props
}) => (
  <div className="dn-p">
    <Button primary color="blue" href="/recipes/new" children="New recipe" />
    <Spacer x={12} y={16} className="dib db-ns" />
    <ModalLink
      primary
      is="btn"
      name="import"
      color="purple"
      children="Import"
    />
    <Spacer x={12} y={16} className="dib db-ns" />
    <Button
      primary
      color="orange"
      href="/explore"
      children="Explore"
      className="mtm mtn-ns"
    />
    <CollectionsMini collections={collections} hidden={hideCollections} />
  </div>
)

RecipesHomeSidebar.propTypes = {
  collections: PropTypes.array,
  hideCollections: PropTypes.bool
}

export default RecipesHomeSidebar
