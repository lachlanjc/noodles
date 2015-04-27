var CookIngredient = React.createClass({
  getInitialState: function(){
    return { checkedClass: '' };
  },

  checkIngredient: function(){
    this.setState({
      checkedClass: ' checked'
    });
  },

  render: function() {
    return (
      <li className={"pointer" + this.state.checkedClass} onClick={this.checkIngredient}>{this.props.ingredient}</li>
    );
  }
});

var IngredientsChecklist = React.createClass({
  getInitialState: function(){
    return { searchString: '' };
  },

  handleChange: function(e){
    this.setState({searchString: e.target.value});
  },

  render: function() {
    var ingredients = this.props.ingredients;
    var searchString = this.state.searchString.trim().toLowerCase();

    if(searchString.length > 0){
      ingredients = ingredients.filter(function(l){
        return l.toLowerCase().match(searchString);
      });
    }

    return (
      <div>
        <h2 className="mb0">Ingredients</h2>
        <p className="grey-4 h5">Click on ingredients to cross them off.</p>

        <div className="search-form col-8 mx-auto mb1 rounded bg-white shadow px2 py1">
          <input
            type="text"
            id="searchBox"
            role="search"
            className="text-input invisible-input full-width"
            value={this.state.searchString}
            onChange={this.handleChange}
            placeholder="Filter ingredients" />
        </div>
        <ul className="ingredients-checklist list-reset">
          {ingredients.map(function(ingredient) {
            return <CookIngredient ingredient={ingredient} />;
          })}
        </ul>
      </div>
    );
  }
});

var CookInstructions = React.createClass({
  render: function() {
    return <div>
      {this.props.instructions.map(function(step) {
        return <div className="lead bg-white rounded shadow p2 block mb2">
          {step}
        </div>;
      })}
    </div>;
  }
});
