var RecipeItem = React.createClass({
  render: function() {
    var notesData, webData, favoriteData;
    var recipeLink = this.props.data.url;
    if (this.props.linkType === "public") {
      recipeLink = this.props.data.shared_url;
    }
    if (this.props.data.favorite === true) {
      favoriteData = <IconFavorite classes="ml1 fill-orange" />;
    }
    if (this.props.data.web === true) {
      webData = <IconWeb classes="ml1 fill-grey-5" />
    }
    if (this.props.data.notes === true) {
      notesData = <IconNotes classes="ml1 up-3 fill-grey-5" size="18" />
    }

    return <a href={recipeLink} className="link-reset">
      <li className="bg-white rounded shadow mb2 p2">
        <div className="right">
          {notesData} {webData} {favoriteData}
        </div>
        <h3 className="m0">{this.props.data.title}</h3>
        <div className="text">{this.props.data.description_preview}</div>
      </li>
    </a>
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
    var linkType = this.props.linkType;
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
      <header className="center m0">
        <h1 className="inline-block">
          {headerText}
          {searchString.length > 0 ? <mark className="rounded grey-2 px1 bg-yellow">{searchString}</mark> : null }
          {this.props.showRandom === true ?
            <a href="/random" className="inline-block">
              <IconRandom classes="inline-block ml1 fill-grey-4 random" />
            </a>
          : null}
        </h1>
      </header>
      : null}
      <div className="search-form col-8 mx-auto flex bg-white rounded shadow mb2 px1">
        <label htmlFor="searchBox" className="mt0">
          <IconSearch classes="fill-grey-4 mt1" />
        </label>
        <input
          type="text"
          id="searchBox"
          role="search"
          className="mb0 text-input invisible-input inline-block col-8"
          value={this.state.searchString}
          onChange={this.handleChange}
          placeholder="Search recipes..." />
      </div>
      <ul className="recipe-list list-reset">
        {recipes.map(function(recipe) {
           return <RecipeItem key={recipe.id} linkType={linkType} data={recipe} />;
        })}
        {(searchString.length > 0) && (recipeCount === 0) ?
          <li className="col-6 bg-white rounded shadow mb2 p2 mx-auto">
            Sorry, no recipes matched your search.
          </li>
        : null}
      </ul>
    </div>);
  }
});
