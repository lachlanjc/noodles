import React from 'react'
import PropTypes from 'prop-types'

import Button from './Button'
import Spacer from './Spacer'
import ModalLink from './ModalLink'
import RecentlyCooked from './RecentlyCooked'
import GroceriesMini from './GroceriesMini'
import CollectionsMini from './CollectionsMini'

const RecipesHomeSidebar = ({
  recipes = [],
  collections = [],
  groceries = [],
  hideModules = false,
  ...props
}) => (
  <div className="dn-p">
    <Button primary color="blue" href="/recipes/new" children="New recipe" />
    <Spacer x={8} y={16} className="dib db-ns" />
    <ModalLink
      primary
      is="btn"
      name="import"
      color="purple"
      children="Import"
    />
    <Spacer x={8} y={16} className="dib db-ns" />
    <Button
      primary
      color="orange"
      href="/explore"
      children="Explore"
      className="mtm mtn-ns"
    />
    {!hideModules && [
      <GroceriesMini groceries={groceries} key="groceries" />,
      <RecentlyCooked
        recipes={recipes}
        hidden={_.size(recipes) < 8}
        key="recently"
      />,
      <CollectionsMini collections={collections} key="collections" />
    ]}
  </div>
)

RecipesHomeSidebar.propTypes = {
  recipes: PropTypes.array,
  collections: PropTypes.array,
  groceries: PropTypes.array,
  hideModules: PropTypes.bool
}

export default RecipesHomeSidebar
