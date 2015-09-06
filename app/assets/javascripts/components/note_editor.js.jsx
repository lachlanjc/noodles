var NoteEditor = React.createClass({
  getInitialState: function() {
    var loading = "Loading notes...";

    return {
      notes_rendered: loading,
      notes_text: loading,
      editing: false,
    };
  },

  componentWillMount: function() {
    this.fetchData();
  },

  fetchData: function() {
    $.getJSON("/recipes/" + this.props.recipe_id + "/notes.json", function(response) {
      this.setState({
        notes_rendered: response.recipe.notes_rendered,
        notes_text: response.recipe.notes_text,
      });
    }.bind(this));
  },

  produceRenderedNotes: function() {
    return {__html: this.state.notes_rendered};
  },

  updateTextNotes: function(e) {
    this.setState({notes_text: e.target.value});
  },

  toggleEditing: function(e) {
    this.setState({editing: !this.state.editing});
  },

  submitNotes: function(e) {
    $.ajax({
      url: "/recipes/" + this.props.recipe_id + "/update_notes",
      dataType: "json",
      type: "patch",
      data: {
        "id": this.props.recipe_id,
        "recipe[notes]": this.state.notes_text
      },
      success: function(data) {
        // Party, because it went through!
      }.bind(this),
      error: function(xhr, status, err) {
        console.error(status, "on", this.props.action, "—", err.toString());
      }.bind(this)
    });
    this.fetchData();
    this.toggleEditing();
  },

  renderEditing: function() {
    return (
      <div>
        <textarea htmlFor="recipe[notes]" className="text-input invisible-input full-width m0" placeholder="Type your notes for the recipe here." rows="4" defaultValue={this.state.notes_text} onChange={this.updateTextNotes} />
        <div className="mb2">
          <button className="btn bg-blue mr1" onClick={this.submitNotes}>Save Notes</button>
          <button className="btn bg-orange" style={{backgroundColor: "#8b909a"}} onClick={this.toggleEditing}>Cancel</button>
        </div>
      </div>
    );
  },

  renderNotes: function() {
    return (
      <div>
        <div dangerouslySetInnerHTML={this.produceRenderedNotes()} />
        <button className="btn bg-blue mt1 mb2" onClick={this.toggleEditing}>Edit Notes</button>
      </div>
    );
  },

  render: function() {
    return (
      <div className="border px2 mt2 rounded notes text text-normalized print-hide">
        <h3 className="mt1 mb1 py1 center grey-4 caps regular border-bottom border-darken-2" style={{borderBottomStyle: "dashed"}}>Notes</h3>
        {(this.state.editing === true) ? this.renderEditing() : this.renderNotes()}
      </div>
    );
  }
});
