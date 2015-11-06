class CollectionPage extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      coll: {}
    };
  }

  componentWillMount() {
    this.fetchData()
  }

  componentDidMount() {
    activateModals()
  }

  fetchData() {
    const dataPath = this.props.pub ? `/c/data/${this.props.id}.json` : `/collections/${this.props.id}.json`;
    $.getJSON(dataPath, function(response) {
      this.setState({coll: response.collection});
    }.bind(this));
  }

  renderPage() {
    const pub = this.props.pub;
    return (
      <main>
        <CollectionHeader edit={this.props.edit} pub={pub} coll={this.state.coll} />
        {!_.isEmpty(this.state.coll.recipes) ?
          <RecipeList recipesCore={this.state.coll.recipes} linkType={pub ? 'public' : 'private'} className='md-col-8 phm' />
        : this.renderNoRecipes()}
      </main>
    )
  }

  renderNoRecipes() {
    return (
      <BlankSlate>
        <h3 className='man normal'>No recipes in this collection yet.</h3>
        {this.props.pub ? null : this.renderAddRecipes()}
      </BlankSlate>
    )
  }

  renderAddRecipes() {
    return (
      <div>
        <a data-behavior='modal_trigger' href='#addRecipes' className='btn bg-blue mtm'>
          Add {_.isEmpty(this.state.coll.recipes) ? 'your first' : 'more'} recipes
        </a>
        <section className='modal' role='dialog' id='addRecipes'>
          <div className='fill-grey-4 db fr pointer' data-behavior='modal_close'>
            <IconClose />
          </div>
          <h2>Add Recipes</h2>
          <hr />
          <CollectionRecipePicker coll={this.state.coll} recipes={this.state.coll.recipes} />
        </section>
      </div>
    )
  }

  renderLoading() {
    return <h3 className='tc grey-3 pvl'>Loading...</h3>
  }

  render() {
    return !_.isEmpty(this.state.coll) ? this.renderPage() : this.renderLoading()
  }
}
