class RecipeList extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      searchText: '',
      recipes: []
    };
  }

  componentDidMount() {
    this.setState({recipes: this.props.recipesCore});
    this.focusSearch();
  }

  componentWillReceiveProps(newProps, newState) {
    this.setState({recipes: newProps.recipesCore});
    return true;
  }

  focusSearch(e) {
    React.findDOMNode(this.refs.searchField).focus();
  }

  _updateSearch(e) {
    const searchText = _.trimLeft(e.target.value.toLowerCase());
    this.setState({searchText: searchText});

    if (searchText.length > 0) {
      let recipes = _.filter(this.props.recipesCore, function(l) {
        return _.trim(l.title.toLowerCase()).match(searchText);
      });
      if (searchText === '/shared' || searchText === '/share' || searchText === '/public') {
        recipes = _.filter(this.props.recipesCore, function(l) {
          return l.shared;
        });
      }
      this.setState({recipes: recipes});
    } else {
      this.setState({recipes: this.props.recipesCore});
    }
  }

  render() {
    const linkType = this.props.linkType || 'normal';

    const searching = this.state.searchText.length > 0;
    const recipeCount = this.props.recipesCore.length
    const searchLabel = 'Search ' +
                        (recipeCount != 1 ? 'these ' : 'this ') +
                        recipeCount + (recipeCount != 1 ? ' recipes' : ' recipe') + '...';

    const noSearchResults = searching && (this.state.recipes.length === 0);
    const createFromSearch = searching && ((this.props.createFromSearch || false) === true);

    return (
      <ul className='list-reset py2'>
        <div className='md-col-8 mx-auto flex bg-white rounded shadow mb2 px1 print-hide' role='search' onClick={this.focusSearch}>
          <IconSearch classes='fill-grey-4 mt1' />
          <input
              type='text'
              ref='searchField'
              className='text-input invisible-input'
              value={this.state.searchText}
              onChange={e => this._updateSearch(e)}
              style={{height: 36}}
              placeholder={searchLabel}
              autoFocus='true' />
        </div>

        {this.state.recipes.map(function(recipe) {
           return <RecipeItem recipe={recipe} linkType={linkType} key={`recipe-${recipe.id}`} />;
        }.bind(this))}

        {noSearchResults ?
          <BlankSlate width='8'>
            <p className='mb0'>Sorry, no recipes matched your search.</p>

            {createFromSearch ?
              <a className='mt2 btn bg-blue' href={'/recipes/new?' + $.param({title: this.state.searchText})}>
                New recipe with this title
              </a>
            : null}
          </BlankSlate>
        : null}
      </ul>
    )
  }
}

class RecipeItem extends React.Component {
  render() {
    const recipe = this.props.recipe;
    const recipeLink = this.props.linkType === 'public' ? recipe.shared_url : recipe.url;

    let indicators = [];
    recipe.collections === true ? indicators.push(<IconCollection classes='ml1 fill-grey-5' size='24px' />) : null;
    recipe.notes === true ? indicators.push(<IconNotes classes='ml1 up-3 fill-grey-5' size='18px' />) : null;
    recipe.photo === true ? indicators.push(<IconPhoto classes='ml1 fill-grey-5' />) : null;
    recipe.web === true ? indicators.push(<IconWeb classes='ml1 fill-grey-5' />) : null;
    recipe.favorite === true ? indicators.push(<IconFavorite classes='ml1 fill-orange' />) : null;

    return (
      <li className='bg-white rounded shadow mb2 p2'>
        <a href={recipeLink} className='link-reset'>
          <div className='right print-hide'>{indicators}</div>
          <h3 className='m0'>{recipe.title}</h3>
          <p className='m0 text'>{recipe.description_preview}</p>
        </a>
      </li>
    )
  }
}
