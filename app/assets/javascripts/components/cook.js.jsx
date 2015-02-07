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
      // Searching! Filter ingredients.
      ingredients = ingredients.filter(function(l){
        return l.toLowerCase().match(searchString);
      });
    }

    return <div>
      <div className="search-form col-8 mx-auto flex bg-white shadow mt1 mb1 px1">
        <label htmlFor="searchBox">
          <IconSearch />
        </label>
        <input
          type="text"
          id="searchBox"
          className="text-input invisible-input col-8 m0"
          value={this.state.searchString}
          onChange={this.handleChange}
          placeholder="Filter ingredients" />
      </div>
      {ingredients.map(function(ingredient) {
        return <label>
          <input type="checkbox" className="checkbox checklist" />
          <span>{ingredient}</span>
        </label>;
      })}
    </div>;
  }
});

var CookInstructions = React.createClass({
  render: function() {
    return <div>
      {this.props.instructions.map(function(step) {
        return <div className="bg-white rounded shadow p2 block mb2 control">
          <label className="h2">
            <input type="checkbox" className="control-checkbox instructions-checklist" />
            {step}
          </label>
        </div>;
      })}
    </div>;
  }
});
