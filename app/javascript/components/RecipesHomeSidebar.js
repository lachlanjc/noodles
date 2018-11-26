import React from 'react'
import PropTypes from 'prop-types'

import Button from './Button'
import Icon from './Icon'
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
    <div className="flex flex-rows">
      <Button
        primary
        color="blue"
        href="/recipes/new"
        className="flex-i fac mvs"
      >
        <Icon glyph="post" size={28} />
        <span>New recipe</span>
      </Button>
      <div className="flex-auto" />
      <ModalLink
        primary
        is="btn"
        name="import"
        color="pink"
        className="flex-i fac mvs"
      >
        <Icon glyph="link" size={28} />
        <span>Import</span>
      </ModalLink>
    </div>
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
