import React, { Component } from 'react'
import PropTypes from 'prop-types'

import BlankSlate from './BlankSlate'
import Button from './Button'
import RecipeListComplication from './RecipeListComplication'
import RecipeListItem from './RecipeListItem'
import SearchBar from './SearchBar'

class RecipeList extends Component {
  static propTypes = {
    recipesCore: PropTypes.array.isRequired,
    pub: PropTypes.bool,
    createFromSearch: PropTypes.bool,
    className: PropTypes.string
  }

  static defaultProps = {
    recipesCore: [],
    hideFilter: false,
    createFromSearch: false,
    pub: false
  }

  state = {
    searchText: '',
    favorites: false,
    recipes: _.sortBy(this.props.recipesCore, 'title')
  }

  static getDerivedStateFromProps(newProps, newState) {
    this.setState({ recipes: _.sortBy(newProps.recipesCore, 'title') })
    return this.state.recipes
  }

  constructor(props) {
    super(props)
    this.toggle = null
  }

  componentDidMount() {
    this.toggle.onclick = e => {
      this.setState({ favorites: !this.state.favorites })
    }
  }

  updateSearch = e => {
    const searchText = _.trimStart(_.lowerCase(e.target.value))
    this.setState({ searchText })

    let recipes = this.props.recipesCore
    if (!_.isEmpty(searchText)) {
      recipes = _.filter(recipes, l => _.lowerCase(l.title).match(searchText))
    }
    this.setState({ recipes })
  }

  render() {
    const {
      recipesCore,
      hideFilter,
      createFromSearch,
      className,
      pub,
      children
    } = this.props
    const { searchText, favorites } = this.state

    const searching = !_.isEmpty(searchText)
    const recipes = favorites
      ? _.filter(this.state.recipes, 'favorite')
      : this.state.recipes

    return (
      <div className={className}>
        <SearchBar
          onChange={this.updateSearch}
          count={_.size(recipesCore)}
          autoFocus
        >
          {!hideFilter && <RecipeListComplication
            actionRef={a => (this.toggle = a)}
            glyph={favorites ? 'like-fill' : 'like'}
            color={favorites ? 'purple' : 'grey-3'}
            tooltip={favorites ? 'Show all recipes' : 'Only show favorites'}
          />}
          {children}
        </SearchBar>
        <ul className="list-reset mx-auto mbn">
          {_.map(recipes, recipe => (
            <RecipeListItem recipe={recipe} pub={pub} key={`r-${recipe.id}`} />
          ))}
          {searching &&
            _.isEmpty(recipes) && (
              <BlankSlate>
                <h3 className="man">No search results 🔍</h3>
                <p className="mbn">
                  Try searching for something less specific.
                </p>
                {createFromSearch && (
                  <Button
                    color="blue"
                    href={`/recipes/new?${$.param({ title: searchText })}`}
                    children="New recipe with this title"
                  />
                )}
              </BlankSlate>
            )}
        </ul>
      </div>
    )
  }
}
export default RecipeList
