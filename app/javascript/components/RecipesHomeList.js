import React from 'react'
import PropTypes from 'prop-types'

import Document from './Document'
import RecipeList from './RecipeList'
import RecipeListComplication from './RecipeListComplication'
import ProTip from './ProTip'

const RecipesHomeList = ({ recipes }) => (
  <Document
    mw={7}
    className="pan oh"
    style={{
      height: 'intrinsic',
      borderRadius: 10
    }}
  >
    <RecipeList
      recipesCore={recipes}
      pub={false}
      createFromSearch
      searchCommands
    >
      <RecipeListComplication
        href={_.sample(_.map(recipes, _.property('path')))}
        glyph="idea"
        tooltip="Open a random recipe"
      />
    </RecipeList>
    <ProTip />
  </Document>
)

RecipesHomeList.propTypes = {
  recipes: PropTypes.array.isRequired
}

export default RecipesHomeList
