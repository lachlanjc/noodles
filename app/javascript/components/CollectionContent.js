import React from 'react'
import PropTypes from 'prop-types'

import RecipeList from './RecipeList'
import CollectionBlankSlate from './CollectionBlankSlate'

const CollectionContent = ({ id, recipes, photo, pub }) =>
  !_.isEmpty(recipes) ? (
    <RecipeList
      recipesCore={recipes}
      pub={pub}
      hideFilter={pub}
      className={!_.isEmpty(photo) && 'document mw7 pan oh mbl'}
    />
  ) : (
    <CollectionBlankSlate id={id} pub={pub} />
  )

CollectionContent.propTypes = {
  id: PropTypes.number.isRequired,
  recipes: PropTypes.array.isRequired,
  photo: PropTypes.string,
  pub: PropTypes.bool
}

export default CollectionContent
