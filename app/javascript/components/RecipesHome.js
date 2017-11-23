import React from 'react'
import PropTypes from 'prop-types'

import RecipesHomeList from './RecipesHomeList'
import RecipesHomeSidebar from './RecipesHomeSidebar'
import SplitLayout from './SplitLayout'

const RecipesHome = ({ recipes, collections }) => (
  <SplitLayout
    className="pvm phl-ns"
    heading="Recipes"
    sidebar={<RecipesHomeSidebar recipes={recipes} collections={collections} />}
    content={<RecipesHomeList recipes={recipes} />}
  />
)

RecipesHome.propTypes = {
  recipes: PropTypes.array.isRequired,
  collections: PropTypes.array
}

export default RecipesHome
