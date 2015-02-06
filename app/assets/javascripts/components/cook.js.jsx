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
