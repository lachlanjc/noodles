class NoteEditor extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      renderedNotes: '<p>Loading...</p>',
      plainNotes: 'Loading...',
      editing: false
    };
    this.updateTextNotes = this.updateTextNotes.bind(this);
    this.toggleEditing = this.toggleEditing.bind(this);
    this.submitNotes = this.submitNotes.bind(this);
  }

  componentWillMount() {
    this.fetchData()
  }

  fetchData() {
    $.getJSON('/recipes/' + this.props.recipe_id + '/notes.json', function(response) {
      this.setState({
        renderedNotes: response.recipe.notes_rendered,
        plainNotes: response.recipe.notes_text,
      })
    }.bind(this))
  }

  produceRenderedNotes() {
    return {__html: this.state.renderedNotes}
  }

  updateTextNotes(e) {
    this.setState({plainNotes: e.target.value})
  }

  toggleEditing(e) {
    this.setState({editing: !this.state.editing})
  }

  submitNotes(e) {
    const component = this;
    $.ajax({
      url: '/recipes/' + this.props.recipe_id + '/update_notes',
      dataType: 'json',
      type: 'patch',
      data: {
        'id': this.props.recipe_id,
        'recipe[notes]': this.state.plainNotes
      },
      success() {
        component.fetchData();
        component.toggleEditing()
      },
      error(xhr, status, err) { console.error(status, '—', err) }
    });
  }

  renderEditing() {
    return (
      <div>
        <textarea htmlFor='recipe[notes]' className='text-input invisible-input col-12 m0' placeholder='Type your notes for the recipe here.' rows='4' defaultValue={this.state.plainNotes} onChange={this.updateTextNotes} />
        <div className='mb2'>
          <button className='btn bg-blue btn-sm mr1' onClick={this.submitNotes}>Save Notes</button>
          <button className='btn bg-orange btn-sm' style={{backgroundColor: '#8b909a'}} onClick={this.toggleEditing}>Cancel</button>
        </div>
      </div>
    )
  }

  renderNotes() {
    return (
      <div>
        <div dangerouslySetInnerHTML={this.produceRenderedNotes()} />
        <button className='btn bg-blue btn-sm mt1 mb2' onClick={this.toggleEditing}>Edit Notes</button>
      </div>
    )
  }

  render() {
    return (
      <section className='border px2 mt2 rounded notes text text-normalized print-hide'>
        <h3 className='mt1 mb1 py1 center grey-4 caps regular border-bottom border-darken-2' style={{borderBottomStyle: 'dashed'}}>Notes</h3>
        {(this.state.editing === true) ? this.renderEditing() : this.renderNotes()}
      </section>
    )
  }
}
