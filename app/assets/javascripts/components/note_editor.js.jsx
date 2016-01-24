class NoteEditor extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      renderedNotes: this.props.rendered,
      plainNotes: this.props.plain,
      editing: false
    };
    this.updateTextNotes = this.updateTextNotes.bind(this);
    this.toggleEditing = this.toggleEditing.bind(this);
    this.submitNotes = this.submitNotes.bind(this);
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
    const self = this;
    $.ajax({
      url: `/recipes/${self.props.id}`,
      dataType: 'json',
      type: 'patch',
      data: {
        'recipe[notes]': self.state.plainNotes
      },
      success(response) {
        self.toggleEditing()
        self.setState({
          renderedNotes: response.recipe.notes_rendered,
          plainNotes: response.recipe.notes_text,
        })
      },
      error(xhr, status, err) { console.error(status, '—', err) }
    });
  }

  renderEditing() {
    return (
      <div>
        <textarea htmlFor='recipe[notes]' rows='4'
          className='text-input invisible-input col-12 man'
          placeholder='Type your notes for the recipe here.'
          defaultValue={this.state.plainNotes} onChange={this.updateTextNotes} />
        <action className='dib dn-p blue blue-dark--hover pointer mrm' onClick={this.submitNotes}>
          Save Notes
        </action>
        <action className='dib dn-p grey-2 grey-2--hover pointer' onClick={this.toggleEditing}>
          Cancel
        </action>
      </div>
    )
  }

  renderNotes() {
    return (
      <div className='text text-normalized'>
        <div dangerouslySetInnerHTML={this.produceRenderedNotes()} />
        {this.props.allowEditing ?
          <action className='dib blue blue-dark--hover pointer' onClick={this.toggleEditing}>
            Edit Notes
          </action>
        : null}
      </div>
    )
  }

  render() {
    const editing = (this.state.editing === true && this.props.allowEditing === true);
    return (
      <section className='mw6 mx-auto border pam mbm rounded bg-notes'>
        <h3 className='mtn mbs tc grey-4 caps'>Notes</h3>
        {editing ? this.renderEditing() : this.renderNotes()}
      </section>
    )
  }
}
