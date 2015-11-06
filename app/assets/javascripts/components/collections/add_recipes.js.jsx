class CollectionRecipePicker extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      recipesCore: [],
      recipes: []
    };
  }

  componentWillMount() {
    this.fetchData()
  }

  fetchData() {
    $.getJSON('/recipes.json', function(data) {
      this.setState({recipesCore: data.recipes, recipes: data.recipes});
    }.bind(this))
  }

  _updateSearch(e) {
    const searchText = _.trimLeft(e.target.value.toLowerCase());
    this.setState({searchText: searchText});

    if (!_.isEmpty(searchText)) {
      const recipes = _.filter(this.state.recipesCore, function(l) {
        return _.trim(l.title.toLowerCase()).match(searchText);
      });
      this.setState({recipes: recipes});
    } else {
      this.setState({recipes: this.state.recipesCore});
    }
  }

  render() {
    return (
      <div>
        <div className='md-col-8 mx-auto flex rounded border mbm phs dn-p' role='search' onClick={this.focusSearch}>
          <IconSearch classes='fill-grey-4 mts' />
          <input
            type='text' autoFocus={true}
            className='text-input invisible-input' style={{height: 36}}
            value={this.state.searchText} placeholder='Search for a recipe...'
            onChange={e => this._updateSearch(e)} />
        </div>
        <ul className='tl list-reset border-top modal-scroll'>
          {this.state.recipes.map(recipe =>
            <RecipePickerItem key={`recipe-${recipe.id}`} recipe={recipe} />
          )}
        </ul>
      </div>
    )
  }
}

class RecipePickerItem extends React.Component {
  render() {
    const recipe = this.props.recipe;
    return (
      <li className='border-bottom pas'>{recipe.title}</li>
    )
  }
}
