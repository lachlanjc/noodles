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
      const recipes = _.compact(response.recipes);
      this.setState({recipesCore: recipes, recipesCurrent: recipes});
    }.bind(this))
  }

  findAll(e) {
    this.setState({
      recipesCurrent: this.state.recipesCore,
      view: 'all'
    })
  }

  findFav(e) {
    this.setState({
      recipesCurrent: _.where(this.state.recipesCore, { 'favorite': true }),
      view: 'fav'
    });
  }

  filterClasses(name) {
    let classes = 'inline-block px2 pointer '
    this.state.view === name ? classes += 'bg-orange white white-hover bold' : classes += 'grey-1';
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
    const recipes = _.compact(this.state.recipesCurrent);
    const randomUrl = (recipes.length > 0) ? '/recipes/' + _.sample(recipes).id.toString() : null;

    return (
      <main className='sm-col-11 md-col-8 mx-auto'>
        <header className='center'>
          <h1 className='mb1'>Recipes</h1>
          <section role='menubar' style={{lineHeight: 2}}>
            <a role='menuitem' onClick={e => this.findAll(e)} className={this.filterClasses('all')} style={{borderRadius: 16}}>All</a>
            <a role='menuitem' onClick={e => this.findFav(e)} className={this.filterClasses('fav')} style={{borderRadius: 16}}>Favorites</a>
            {randomUrl ? <a role='menuitem' href={randomUrl} className={this.filterClasses('rdm')}>Random</a> : null}
          </section>
        </header>
        <RecipeList recipesCore={this.state.recipesCurrent} createFromSearch={true} />
        {this.state.view === 'fav' && this.state.recipesCurrent.length == 0 ? this.renderFavoritesBlankSlate() : null}
      </main>
    )
  }
}
