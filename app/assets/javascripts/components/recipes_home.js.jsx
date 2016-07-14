
class RecipesHome extends React.Component {
  constructor(props) {
    super(props)
    this.state = {
      recipesCore: [],
      recipesCurrent: [],
      view: 'all',
    }
  }

  componentWillMount() {
    this.fetchData()
    this.findAll()
  }

  fetchData() {
    $.getJSON('/recipes.json', response => {
      this.setState({
        recipesCore: response.recipes,
        recipesCurrent: response.recipes,
      })
    })
  }

  findAll(e) {
    this.setState({
      recipesCurrent: this.state.recipesCore,
      view: 'all'
    })
  }

  findFav(e) {
    this.setState({
      recipesCurrent: _.filter(this.state.recipesCore, 'favorite'),
      view: 'fav'
    })
  }

  render() {
    const recipes = this.state.recipesCurrent
    return (
      <main className='md-col-9 mx-auto pam'>
        <header>
          <h1 className='mtn mbs tc'>Recipes</h1>
          <FilterBar>
            <FilterBarItem active={this.state.view} view='all' name='All' onClick={e => this.findAll(e)} />
            <FilterBarItem active={this.state.view} view='fav' name='Favorites' onClick={e => this.findFav(e)} />
            {!_.isEmpty(recipes) &&
              <FilterBarItem active={this.state.view} view='rdm' name='Random' href={_.sample(recipes).url} />
            }
          </FilterBar>
        </header>
        <RecipeList recipesCore={recipes} pub={false} createFromSearch={true} searchCommands={true} />
        {_.isEmpty(recipes) ? this.renderBlankSlate() : <ProTip />}
      </main>
    )
  }

  renderBlankSlate() {
    const text = <h3 className='man'>No recipes here yet!</h3>
    return (
      <BlankSlate margin='mtn mbm'>
        {this.state.view === 'fav' ? this.renderFavoritesBlankSlate() : text}
      </BlankSlate>
    )
  }

  renderFavoritesBlankSlate() {
    return (
      <div>
        <h3 className='mtn'>No favorites yet.</h3>
        <p>Favorites are an easy way to quickly bookmark recipes. They're marked with a star.</p>
        <p>To favorite a recipe, open the recipe and click the star to the right of the recipe's title.</p>
        <a onClick={e => this.findAll(e)} className='btn bg-blue'>Back to all recipes</a>
      </div>
    )
  }
}
