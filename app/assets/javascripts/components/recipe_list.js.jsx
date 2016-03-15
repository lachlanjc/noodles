class RecipeList extends React.Component {
  constructor(props) {
    super(props)
    this.state = {
      searchText: '',
      recipes: []
    }
  }

  componentDidMount() {
    this.setState({ recipes: _.sortBy(this.props.recipesCore, 'title') })
  }

  componentWillReceiveProps(newProps, newState) {
    this.setState({ recipes: _.sortBy(newProps.recipesCore, 'title') })
    return true
  }

  _updateSearch(e) {
    const searchText = _.trimStart(_.lowerCase(e.target.value))
    this.setState({ searchText: searchText })

    if (!_.isEmpty(searchText)) {
      let recipes = this.props.recipesCore
      recipes = _.filter(recipes, function(l) {
        return _.lowerCase(l.title).match(searchText);
      })
      this.setState({ recipes: recipes })
    } else {
      this.setState({ recipes: this.props.recipesCore })
    }
  }

  render() {
    const props = this.props
    const searching = !_.isEmpty(this.state.searchText)
    const recipeCount = _.size(this.props.recipesCore)
    const noSearchResults = searching && _.isEmpty(this.state.recipes)
    const createFromSearch = searching && (this.props.createFromSearch || false)

    let searchLabel = 'Search '
    searchLabel += (recipeCount != 1 ? 'these ' : 'this ')
    searchLabel += recipeCount + (recipeCount != 1 ? ' recipes' : ' recipe') + '...'

    return (
      <ul className={`list-reset pvm mx-auto mbn mw7 ${this.props.className}`}>
        <SearchBar className='md-col-8 mx-auto mbm'
                   onChange={e => this._updateSearch(e)}
                   placeholder={searchLabel}
                   autoFocus={true} />

        {_.map(this.state.recipes, function (recipe) {
          return <RecipeItem recipe={recipe} pub={props.pub || false} key={'recipe-' + recipe.id} />
        })}

        {noSearchResults ?
          <BlankSlate width={8}>
            <p className='mbn'>Sorry, no recipes matched your search.</p>

            {createFromSearch ?
              <a className='mtm btn bg-blue'
                 href={'/recipes/new?' + $.param({ title: this.state.searchText })}>
                New recipe with this title
              </a>
            : null}
          </BlankSlate>
        : null}
      </ul>
    )
  }
}

RecipeList.propTypes = {
  recipesCore: React.PropTypes.array.isRequired,
  pub: React.PropTypes.bool
}

class RecipeItem extends React.Component {
  render() {
    const recipe = this.props.recipe;
    const recipeLink = this.props.pub === true ? recipe.shared_url : recipe.url;

    let icns = [];
    _.forEach(['collections', 'notes', 'photo', 'web'], function (feature) {
      if (recipe[feature] === true) {
        icns.push(<Icon icon={feature} className='mls fill-grey-5' />);
      }
    });
    recipe.favorite === true ? icns.push(<Icon icon='fav' className='mls fill-orange' />) : null;

    return (
      <li className='bg-white rounded shadow mbs pam'>
        <a href={recipeLink} className='link-reset'>
          <div className='fr dn-p'>{icns}</div>
          <h3 className='man normal'>{recipe.title}</h3>
          <p className='man text'>{recipe.description_preview}</p>
        </a>
      </li>
    )
  }
}

RecipeItem.propTypes = {
  recipe: React.PropTypes.object.isRequired,
  pub: React.PropTypes.bool
}
