
class RecipeList extends React.Component {
  constructor (props) {
    super(props)
    this.state = {
      searchText: '',
      recipes: []
    }
  }

  componentDidMount () {
    this.setState({ recipes: _.sortBy(this.props.recipesCore, 'title') })
  }

  componentWillReceiveProps (newProps, newState) {
    this.setState({ recipes: _.sortBy(newProps.recipesCore, 'title') })
    return true
  }

  _updateSearch (e) {
    const searchText = _.trimStart(_.lowerCase(e.target.value))
    this.setState({ searchText })

    if (!_.isEmpty(searchText)) {
      let recipes = this.props.recipesCore
      recipes = _.filter(recipes, l => {
        return _.lowerCase(l.title).match(searchText)
      })
      this.setState({ recipes })
    } else {
      this.setState({ recipes: this.props.recipesCore })
    }
  }

  render () {
    const { recipesCore, createFromSearch, className, pub, children } = this.props
    const { recipes, searchText } = this.state

    const searching = !_.isEmpty(searchText)

    return (
      <div className={className}>
        <SearchBar
          onChange={e => this._updateSearch(e)}
          count={_.size(recipesCore)}
          autoFocus={true}
          children={children}
        />
        <ul className='list-reset mx-auto mbn'>
          {_.map(recipes, recipe => (
            <RecipeListItem
              recipe={recipe}
              pub={pub || false}
              key={`r${recipe.id}`}
            />
          ))}
          {searching && _.isEmpty(recipes) &&
            <BlankSlate>
              <h3 className='normal man'>No search results</h3>
              <p className='mbn'>Try searching for something less specific. 🔍</p>
              {searching && (createFromSearch || false) &&
                <a
                  className='mtm btn bg-blue'
                  href={'/recipes/new?' + $.param({ title: searchText })}
                  children='New recipe with this title'
                />
              }
            </BlankSlate>
          }
        </ul>
      </div>
    )
  }
}

RecipeList.propTypes = {
  recipesCore: React.PropTypes.array.isRequired,
  pub: React.PropTypes.bool,
  createFromSearch: React.PropTypes.bool,
  className: React.PropTypes.string
}
