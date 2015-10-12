class RecipeList extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      searchText: '',
      recipes: []
    };
  }

  componentDidMount() {
    this.setState({recipes: _.sortBy(this.props.recipesCore, 'title')});
    this.focusSearch();
  }

  componentWillReceiveProps(newProps, newState) {
    this.setState({recipes: _.sortBy(newProps.recipesCore, 'title')});
    return true;
  }

  focusSearch(e) {
    React.findDOMNode(this.refs.searchField).focus();
  }

  _updateSearch(e) {
    const searchText = _.trimLeft(e.target.value.toLowerCase());
    this.setState({searchText: searchText});

    if (searchText.length > 0) {
      let recipes = this.props.recipesCore;
      if (this.props.searchCommands == true && _.startsWith(searchText, '/')) {
        if (_.intersection(searchText, 'shared').join('') || _.intersection(searchText, 'public').join('')) {
          recipes = _.filter(recipes, function(l) { return l.shared });
        }
      } else {
        recipes = _.filter(recipes, function(l) {
          return _.trim(l.title.toLowerCase()).match(searchText);
        });
      }
      this.setState({recipes: recipes});
    } else {
      this.setState({recipes: this.props.recipesCore});
    }
  }

  render() {
    const linkType = this.props.linkType || 'normal';

    const searching = !_.isEmpty(this.state.searchText);
    const recipeCount = _.size(this.props.recipesCore);
    const searchLabel = 'Search ' +
                        (recipeCount != 1 ? 'these ' : 'this ') +
                        recipeCount + (recipeCount != 1 ? ' recipes' : ' recipe') + '...';

    const noSearchResults = searching && _.isEmpty(this.state.recipes);
    const createFromSearch = searching && ((this.props.createFromSearch || false) === true);

    return (
      <ul className={'list-reset pvm mx-auto mb0 mw7 ' + this.props.className}>
        <div className='md-col-8 mx-auto flex bg-white rounded shadow mb2 phs print-hide' role='search' onClick={this.focusSearch}>
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
           return <RecipeItem recipe={recipe} linkType={linkType} key={recipe.id} />;
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
    recipe.notes === true ? indicators.push(<IconNotes classes='ml1 relative fill-grey-5' size='18px' style={{top: '-3px'}} />) : null;
    recipe.photo === true ? indicators.push(<IconPhoto classes='ml1 fill-grey-5' />) : null;
    recipe.web === true ? indicators.push(<IconWeb classes='ml1 fill-grey-5' />) : null;
    recipe.favorite === true ? indicators.push(<IconFavorite classes='ml1 fill-orange' />) : null;

    return (
      <li className='bg-white rounded shadow mb2 pam'>
        <a href={recipeLink} className='link-reset'>
          <div className='right print-hide'>{indicators}</div>
          <h3 className='m0 regular'>{recipe.title}</h3>
          <p className='m0 text'>{recipe.description_preview}</p>
        </a>
      </li>
    )
  }
}
