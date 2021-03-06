import React, { useState } from 'react'
import PropTypes from 'prop-types'
import Fuse from 'fuse.js'

import BlankSlate from './BlankSlate'
import Button from './Button'
import RecipeListComplication from './RecipeListComplication'
import RecipeListItem from './RecipeListItem'
import SearchBar from './SearchBar'

const RecipeList = ({
  recipesCore,
  hideFilter,
  createFromSearch,
  className,
  pub,
  children
}) => {
  let recipes = _.sortBy(recipesCore, 'title')

  const [search, setSeach] = useState('')
  const handleInputChange = e => setSeach(e.target.value)

  const [favorites, setFavorites] = useState(false)
  if (favorites) recipes = _.filter(recipes, 'favorite')

  const keys = ['title', 'description']
  const fuse = new Fuse(recipes, { threshold: 0.4, keys })
  const searching = !_.isEmpty(search)
  if (searching) recipes = fuse.search(search)

  return (
    <div className={className}>
      <SearchBar
        onChange={handleInputChange}
        count={_.size(recipesCore)}
        autoFocus
      >
        {children}
        {/* {!hideFilter && (
          <RecipeListComplication
            is="button"
            onClick={setFavorites}
            glyph={favorites ? 'like-fill' : 'like'}
            color={favorites ? 'pink' : 'grey-3' + ' invisible-input'}
            tooltip={favorites ? 'Show all recipes' : 'Only show favorites'}
          />
        )} */}
      </SearchBar>
      <ul className="list-reset mx-auto mbn">
        {_.map(recipes, recipe => (
          <RecipeListItem recipe={recipe} pub={pub} key={recipe.id} />
        ))}
        {searching && _.isEmpty(recipes) && (
          <BlankSlate>
            <h3 className="man">No search results 🔍</h3>
            <p className={createFromSearch ? 'mb2' : 'mbn'}>
              Try searching for something less specific.
            </p>
            {createFromSearch && (
              <Button
                color="blue"
                href={`/recipes/new?${$.param({ title: search })}`}
                children="New recipe with this title"
              />
            )}
          </BlankSlate>
        )}
      </ul>
    </div>
  )
}

RecipeList.propTypes = {
  recipesCore: PropTypes.array.isRequired,
  pub: PropTypes.bool,
  createFromSearch: PropTypes.bool,
  className: PropTypes.string
}

RecipeList.defaultProps = {
  recipesCore: [],
  hideFilter: false,
  createFromSearch: false,
  pub: false
}

export default RecipeList
