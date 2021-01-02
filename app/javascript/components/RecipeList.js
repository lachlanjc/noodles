import React, { useEffect, useState } from 'react'
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
  const [recipes, setRecipes] = useState(recipesCore)
  const [sort, setSort] = useState('title')
  const [search, setSeach] = useState('')

  const keys = ['title', 'description']
  const fuse = new Fuse(recipesCore, { threshold: 0.4, keys })
  const handleInputChange = e => setSeach(e.target.value)

  useEffect(() => {
    if (isEmpty(search)) {
      setRecipes(recipesCore)
    } else {
      setRecipes(fuse.search(search))
    }
  }, [search])

  useEffect(() => {
    if (sort === 'favorite') {
      setRecipes(_.filter(recipes, 'favorite'))
    } else {
      setRecipes(_.sortBy(recipesCore, sort))
    }
  }, [recipes, sort])

  return (
    <div className={className}>
      <SearchBar
        onChange={handleInputChange}
        count={_.size(recipesCore)}
        autoFocus
      >
        {children}
        {!hideFilter && (
          <RecipeListComplication
            is="action"
            glyph="filter"
            color={sort !== 'title' ? (sort === 'favorite' ? 'pink' : 'blue') : 'grey-3'}
            tooltip="Sort/filter"
            role="button"
            className="invisible-input menu__toggle"
            data-behavior="menu_toggle"
            aria-expanded={false}
            tabIndex={0}
          >
            <popmenu className="menu__content" data-behavior="menu_content">
              <a className="menu__action" href="#" onClick={() => setSort('')}>
                <Icon glyph={sort === 'title' ? 'checkmark' : "quote"} />
                <span>Title</span>
              </a>
              <a className="menu__action" href="#" onClick={() => setSort('favorite')}>
                <Icon glyph={sort === 'favorite' ? 'checkmark' : "like"} />
                <span>Favorite</span>
              </a>
              <a className="menu__action" href="#" onClick={() => setSort('last_cooked_at')}>
                <Icon glyph={sort === 'last_cooked_at' ? 'checkmark' : "clock"} />
                <span>Recently cooked</span>
              </a>
              <a className="menu__action" href="#" onClick={() => setSort('cooks_count')}>
                <Icon glyph={sort === 'cooks_count' ? 'checkmark' : "food"} />
                <span>Most cooked</span>
              </a>
            </popmenu>
          </RecipeListComplication>
        )}
      </SearchBar>
      <ul className="list-reset mx-auto mbn">
        {_.map(recipes, recipe => (
          <RecipeListItem recipe={recipe} pub={pub} key={recipe.id} />
        ))}
        {!_.isEmpty(search) && _.isEmpty(recipes) && (
          <BlankSlate>
            <h3 className="man">No search results 🔍</h3>
            <p className="mbn">Try searching for something less specific.</p>
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
