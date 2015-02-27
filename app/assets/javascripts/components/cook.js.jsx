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

        <div className="search-form col-8 mx-auto bg-white shadow mt1 mb1 px1">
          <label htmlFor="searchBox" className="mt0 inline-block">
            <IconSearch />
          </label>
          <input
            type="text"
            id="searchBox"
            role="search"
            className="text-input invisible-input col-8 m0 inline-block"
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
        return <div className="bg-white rounded shadow p2 block mb2 control">
          <label className="h2">
            <input type="checkbox" className="hide instructions-checklist" />
            {step}
          </label>
        </div>;
      })}
    </div>;
  }
});
