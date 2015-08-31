class RecipesHome extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      recipesCore: [],
      recipesCurrent: [],
      view: 'all'
    };
  }

  componentWillMount() {
    this.fetchData();
    this.findAll();
  }

  fetchData() {
    $.getJSON('/recipes.json', function(response) {
      this.setState({recipesCore: response.recipes, recipesCurrent: response.recipes});
    }.bind(this))
  }

  findAll(e) {
    this.setState({
      recipesCurrent: this.state.recipesCore,
      view: 'all'
    })
  }

  findFavorites(e) {
    const favRecipes = this.state.recipesCore.filter(function(r) {
      return r.favorite === true;
    });
    this.setState({
      recipesCurrent: favRecipes,
      view: 'fav'
    });
  }

  filterClasses(name) {
    let classes = 'mr1 inline-block px1 pointer '
    this.state.view === name ? classes += 'bg-orange white bold rounded' : classes += 'grey-1';
    return classes;
  }

  renderFavoritesBlankSlate() {
    return (
      <BlankSlate>
        <h3 className='mt0'>No favorites yet.</h3>
        <p>Favorites are an easy way to quickly bookmark recipes. They're marked with a star.</p>
        <p>To favorite a recipe, open the recipe and click the star to the right of the recipe's title.</p>
        <a onClick={e => this.findAll(e)} className='btn bg-blue'>Back to all recipes</a>
      </BlankSlate>
    )
  }

  render() {
    const recipes = this.state.recipesCurrent;
    const randomUrl = (recipes.length > 0) ? '/recipes/' + recipes[Math.floor(Math.random() * recipes.length)].id.toString() : null;

    return (
      <main className='sm-col-11 md-col-8 mx-auto'>
        <header className='center'>
          <h1>Recipes</h1>
          <section role='menubar'>
            <a role='menuitem' onClick={e => this.findAll(e)} className={this.filterClasses('all')}>All</a>
            <a role='menuitem' onClick={e => this.findFavorites(e)} className={this.filterClasses('fav')}>Favorites</a>
            {randomUrl ? <a role='menuitem' href={randomUrl} className={this.filterClasses('rdm')}>Random</a> : null}
          </section>
        </header>
        <RecipeList recipesCore={this.state.recipesCurrent} createFromSearch={true} />
        {this.state.view === 'fav' && this.state.recipesCurrent.length == 0 ? this.renderFavoritesBlankSlate() : null}
      </main>
    )
  }
}
