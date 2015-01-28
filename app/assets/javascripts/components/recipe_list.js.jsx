var RecipeItem = React.createClass({
  render: function() {
    var favoriteData = null;
    if (this.props.data.favorite === true) {
      favoriteData = <IconFavorite />;
    }

    return <a href={this.props.data.url} className="link-reset">
      <div className="panel">
        {favoriteData}
        <h3 className="m0">{this.props.data.title}</h3>
        <div className="text text-muted">{this.props.data.description_preview}</div>
      </div>
    </a>
  }
});
// TODO: Build recipe search in React
var RecipeList = React.createClass({
  render: function() {
    return (
      <div className="recipe-list">
        {this.props.recipes.map(function(recipe) {
           return <RecipeItem key={recipe.id} data={recipe} />;
        })}
      </div>
    );
  }
});
