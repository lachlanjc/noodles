import React from 'react'
import PropTypes from 'prop-types'

import Button from './Button'
import Spacer from './Spacer'
import ModalLink from './ModalLink'
import CollectionsMini from './CollectionsMini'
import RecentlyCooked from './RecentlyCooked'

const RecipesHomeSidebar = ({
  recipes = [],
  collections = [],
  hideCollections = false,
  ...props
}) => (
  <div className="dn-p">
    <Button primary color="blue" href="/recipes/new" children="New recipe" />
    <Spacer x={16} y={16} className="dib db-ns" />
    <ModalLink
      primary
      is="btn"
      name="import"
      color="purple"
      children="Import"
    />
    <Spacer x={16} y={16} className="dib db-ns" />
    <Button
      primary
      color="orange"
      href="/explore"
      children="Explore"
      className="mvm mtn-ns"
    />
    <CollectionsMini collections={collections} hidden={hideCollections} />
    <RecentlyCooked recipes={recipes} hidden={_.size(recipes) < 8} />
  </div>
)

RecipesHomeSidebar.propTypes = {
  recipes: PropTypes.array,
  collections: PropTypes.array,
  hideCollections: PropTypes.bool
}

export default RecipesHomeSidebar
