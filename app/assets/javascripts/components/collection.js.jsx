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

  fetchData() {
    $.getJSON(`/collections/${this.props.id}.json`, function(response) {
      this.setState({coll: response.collection});
    }.bind(this));
  }

  renderPage() {
    return (
      <main>
        <CollectionHeader edit={true} pub={false} coll={this.state.coll} />
        {this.state.coll.recipes.length > 0 ?
          <article className='sm-col-11 md-col-7 mx-auto mt0'>
            <RecipeList recipesCore={this.state.coll.recipes} />
          </article>
        : this.renderNoRecipes()}
      </main>
    )
  }

  renderNoRecipes() {
    return (
      <BlankSlate>
        <h3 className='mt0'>No recipes in this collection yet.</h3>
        <p>Add recipes by clicking "Add to Collection" at the bottom of any of your recipes.</p>
        <a href='/recipes' className='btn bg-blue'>Find some recipes</a>
      </BlankSlate>
    )
  }

  renderLoading() {
    return (
      <h3 className='center grey-3 py3'>Loading...</h3>
    )
  }

  render() {
    return (
      <div>
        {Object.keys(this.state.coll).length != 0 ? this.renderPage() : this.renderLoading()}
      </div>
    )
  }
}

class CollectionHeader extends React.Component {
  componentDidMount() {
    $('[data-behavior~=modal_trigger]').leanModal()
  }

  render() {
    const coll = this.props.coll;

    let rootClass = 'coll-header full-width center grey-4 py2'
    let actionsClass = 'caps h4';
    if (coll.photo.length > 0) {
      rootClass += ' coll-w-img bg-center bg-no-repeat bg-cover p3 mb1';
      actionsClass += ' block white mb2';
    }

    return (
      <header className={rootClass} style={{backgroundImage: `url(${coll.photo})`}}>
        <div className={actionsClass}>
          {this.props.edit === true ?
            <a name='editCollection' href='#editCollection' className='link-reset' data-behavior='modal_trigger'>Edit · </a>
          : null}
          <a name='shareCollection' href='#shareCollection' className='link-reset' data-behavior='modal_trigger'>Share</a>
        </div>
        <h1 className='inline-block coll-name m0 h0'>{coll.name}</h1>
        {coll.description.length > 0 ? <p className='h3 mt1 mb0 coll-desc'>{coll.description}</p> : null}
        {this.props.pub === true ?
          <div className='mt1 mb1 h4 grey-3'>Published by {coll.publisher}</div>
        : null}
      </header>
    )
  }
}
