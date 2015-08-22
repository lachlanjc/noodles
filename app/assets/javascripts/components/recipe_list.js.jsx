var RecipeList = React.createClass({
  getDefaultProps: function() {
    return {
      recipes_path: "/recipes.json",
      header_text: "Recipes",
      show_header: false,
      show_random: false,
      link_type: "normal",
      createFromSearch: false
    };
  },

  getInitialState: function(){
    return {
      header_text: this.props.header_text,
      search_text: "",
      recipes: [],
      recipes_filtered: []
    };
  },

  componentWillMount: function() {
    this.fetchData();
  },

  fetchData: function() {
    $.getJSON(this.props.recipes_path, function(response) {
      this.setState({
        recipes: response.recipes,
        recipes_filtered: response.recipes
      });
    }.bind(this));
  },

  _updateSearch: function(e) {
    this.setState({search_text: e.target.value});

    // Filter recipes
    if (this.state.search_text.length > 0) {
      var recipes_matching_search = this.state.recipes.filter(function(l) {
        return l.title.toLowerCase().match(this.state.search_text.toLowerCase().trim());
      }.bind(this));
      this.setState({
        recipes_filtered: recipes_matching_search,
        header_text: "Searching for "
      });
    }

    // If you clear your search, restore list
    if (this.state.search_text.length === 0) {
      this.setState({
        recipes_filtered: this.state.recipes,
        header_text: this.props.header_text
      });
    }
  },

  render: function() {
    return (
      <div>
        {this.props.show_header ?
          <header className="center m0">
            <h1 className="inline-block">
              {this.state.header_text}
              {this.state.search_text.length > 0 ?
                <mark className="rounded grey-2 px1 bg-yellow">{this.state.search_text}</mark>
              : null}
              {(this.state.search_text.length === 0) && (this.props.show_random) ?
                <a href="/random" className="inline-block">
                  <IconRandom classes="ml1 fill-grey-4 random" />
                </a>
              : null}
            </h1>
          </header>
        : null}
        <div className="search-form col-8 mx-auto flex bg-white rounded shadow mb2 px1">
          <label htmlFor="search-box" className="mt0">
            <IconSearch classes="fill-grey-4 mt1" />
          </label>
          <input
            type="text"
            role="search"
            className="mt0 mb0 text-input invisible-input full-width inline-block"
            value={this.state.search_text}
            onChange={this._updateSearch}
            placeholder="Search recipes..." />
        </div>
        <ul className="recipe-list list-reset">
          {this.state.recipes_filtered.map(function(recipe) {
             return <RecipeItem recipe={recipe} link_type={this.props.link_type} key={recipe.id} />;
          }.bind(this))}
          {(this.state.search_text.length > 0) && (this.state.recipes_filtered.length === 0) ?
            <li className="md-col-8 bg-white rounded shadow mt3 p3 center mx-auto">
              Sorry, no recipes matched your search.
            </li>
          : null}
          {(this.state.search_text.length > 0) && (this.props.createFromSearch === true) ?
          <p className="mt2 mb0 center">
            <a className="btn bg-blue" href={"/recipes/new?" + $.param({title: this.state.search_text})}>
              New recipe with this title
            </a>
          </p>
          : null}
        </ul>
      </div>
    );
  }
});

var RecipeItem = React.createClass({
  render: function() {
    var recipe = this.props.recipe;
    var notesData, photoData, collectionsData, webData, favoriteData;
    var recipeLink = recipe.url;
    if (this.props.link_type === "public") {
      recipeLink = this.props.recipe.shared_url;
    }
    if (recipe.favorite === true) {
      favoriteData = <IconFavorite classes="ml1 fill-orange" />;
    }
    if (recipe.web === true) {
      webData = <IconWeb classes="ml1 fill-grey-5" />
    }
    if (recipe.photo === true) {
      photoData = <IconPhoto classes="ml1 fill-grey-5" />
    }
    if (recipe.notes === true) {
      notesData = <IconNotes classes="ml1 up-3 fill-grey-5" size="18px" />
    }
    if (recipe.collections === true) {
      collectionsData = <IconCollection classes="ml1 fill-grey-5" size="24px" />
    }

    return (
      <a href={recipeLink} className="link-reset">
        <li className="bg-white rounded shadow mb2 p2">
          <div className="right">
            {notesData} {photoData} {collectionsData} {webData} {favoriteData}
          </div>
          <h3 className="m0">{recipe.title}</h3>
          <div className="block text">{recipe.description_preview}</div>
        </li>
      </a>
    );
  }
});
