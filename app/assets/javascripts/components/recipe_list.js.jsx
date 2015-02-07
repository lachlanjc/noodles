var RecipeItem = React.createClass({
  render: function() {
    var favoriteData = null;
    if (this.props.data.favorite === true) {
      favoriteData = <IconFavorite classes="float-right fill-primary" />;
    }

    return <a href={this.props.data.url} className="link-reset">
      <div className="bg-white rounded shadow mb2 p2">
        {favoriteData}
        <h3 className="m0">{this.props.data.title}</h3>
        <div className="text text-muted">{this.props.data.description_preview ? this.props.data.description_preview : null}</div>
      </div>
    </a>
  }
});

var RandomRecipe = React.createClass({
  render: function() {
    if (this.props.showRandom === true) {
      return (<a href="/random" className="ib">
        <IconRandom classes="random" />
      </a>);
    } else {
      return null;
    }
  }
});


var RecipeList = React.createClass({
  getInitialState: function(){
    return { searchString: '' };
  },

  handleChange: function(e){
    this.setState({searchString: e.target.value});
  },

  render: function() {
    var recipes = this.props.recipes;
    var recipeCount = recipes.length;
    var headerText = this.props.headerText;
    var searchString = this.state.searchString.trim().toLowerCase();

    if(searchString.length > 0){
      // Searching! Filter the results.
      recipes = recipes.filter(function(l){
        return l.title.toLowerCase().match(searchString);
      });
      recipeCount = recipes.length;
      headerText = "Searching for "
      this.props.showRandom = false;
    }

    return (<div>
      {this.props.showHeader === true ?
      <header className="text-center m0">
        <h1 className="ib">
          {headerText}
          {searchString.length > 0 ? <mark>{searchString}</mark> : null }
          <RandomRecipe showRandom={this.props.showRandom} />
        </h1>
      </header>
      : null}
      <div className="search-form col-8 mx-auto flex bg-white border mb2 px1">
        <label htmlFor="searchBox">
          <IconSearch />
        </label>
        <input
          type="text"
          id="searchBox"
          className="text-input invisible-input col-8 m0"
          value={this.state.searchString}
          onChange={this.handleChange}
          placeholder="Search recipes..." />
      </div>
      <div className="recipe-list">
        {recipes.map(function(recipe) {
           return <RecipeItem key={recipe.id} data={recipe} />;
        })}
        {(searchString.length > 0) && (recipeCount === 0) ? <div className="col-6 bg-white rounded shadow mb2 p2 mx-auto">Sorry, no recipes matched your search.</div> : null}
      </div>
    </div>);
  }
});
