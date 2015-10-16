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
      recipesCurrent: _.where(this.state.recipesCore, {'favorite': true}),
      view: 'fav'
    });
  }

  findRandom() {
    return !_.isEmpty(this.state.recipesCurrent) ? _.sample(this.state.recipesCurrent).url : null;
  }

  filterClasses(name) {
    let classes = 'filterbar-item dib phm pointer '
    this.state.view === name ? classes += 'bg-orange white white-hover b' : classes += 'grey-1';
    return classes;
  }

  renderBlankSlate() {
    return (
      <BlankSlate>
        <h3 className='man'>No recipes here yet!</h3>
        {/*<a href='/recipes/new' className='btn bg-blue'>Create your first</a>*/}
      </BlankSlate>
    )
  }

  renderFavoritesBlankSlate() {
    return (
      <BlankSlate>
        <h3 className='mtn'>No favorites yet.</h3>
        <p>Favorites are an easy way to quickly bookmark recipes. They're marked with a star.</p>
        <p>To favorite a recipe, open the recipe and click the star to the right of the recipe's title.</p>
        <a onClick={e => this.findAll(e)} className='btn bg-blue'>Back to all recipes</a>
      </BlankSlate>
    )
  }

  renderProTips() {
    const protips = [
      <span>See only your shared recipes by searching <strong>/shared</strong>.</span>,
      <span>Create a new recipe super quickly by searching with its title.</span>,
      <span>Not sure which recipe to cook right now? Click <a className='b' href={this.findRandom()}>Random</a> button at the top.</span>
    ];
    const protip = protips[_.random(0, 2)];
    return (
      <div className='mbl tc'>
        <IconProtip size='24' classes='dib fill-grey-4 mr1 relative' style={{top: 6}} />
        <strong>ProTip! </strong>
        {protip}
      </div>
    )
  }

  render() {
    const recipes = this.state.recipesCurrent;
    const randomUrl = this.findRandom();

    return (
      <main className='md-col-9 mx-auto phm'>
        <header className='tc'>
          <h1 className='mbs'>Recipes</h1>
          <section role='menubar' className='filterbar'>
            <a role='menuitem' onClick={e => this.findAll(e)} className={this.filterClasses('all')}>All</a>
            <a role='menuitem' onClick={e => this.findFav(e)} className={this.filterClasses('fav')}>Favorites</a>
            {randomUrl ? <a role='menuitem' href={randomUrl} className={this.filterClasses('rdm')}>Random</a> : null}
          </section>
        </header>
        <RecipeList recipesCore={this.state.recipesCurrent} createFromSearch={true} searchCommands={true} />
        {this.state.view === 'fav' && _.isEmpty(this.state.recipesCurrent) ? this.renderFavoritesBlankSlate() : null}
        {_.isEmpty(this.state.recipesCurrent) ? this.renderBlankSlate() : this.renderProTips()}
      </main>
    )
  }
}
