var IngredientsChecklist = React.createClass({
  render: function() {
    return <div>
      {this.props.ingredients.map(function(ingredient) {
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
        return <li className="bg-white rounded shadow p2 block h2 text-center mb2">{step}</li>;
      })}
    </div>;
  }
});
