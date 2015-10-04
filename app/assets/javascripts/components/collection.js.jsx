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
          <article className='md-col-8 mx-auto mt0'>
            <RecipeList recipesCore={this.state.coll.recipes} linkType={pub ? 'public' : 'private'} />
          </article>
        : this.renderNoRecipes()}
      </main>
    )
  }

  renderNoRecipes() {
    return (
      <BlankSlate>
        <h3 className='m0'>No recipes in this collection yet.</h3>
        {this.props.pub === false ?
          <div className='mt2'>
            <p>Add recipes by clicking "Add to Collection" at the bottom of any of your recipes.</p>
            <a href='/recipes' className='btn bg-blue'>Find some recipes</a>
          </div>
        : null}
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
        {!_.isEmpty(this.state.coll) ? this.renderPage() : this.renderLoading()}
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

    let rootClass = 'col-12 bs-bb flex flex-center';
    let rootStyle = {};
    let actionsClass = 'caps h4 mt2 print-hide';
    if (!_.isEmpty(coll.photo)) {
      rootClass += ' image-header relative inline-with-nav p3 bg-cover bg-center bg-no-repeat';
      rootStyle.backgroundImage = `url(${coll.photo_url})`;
      actionsClass += ' block white mb2';
    } else {
      rootClass += ' center grey-4 py2';
    }

    return (
      <header className={rootClass} style={{backgroundImage: `url(${coll.photo})`}}>
        <div className='sm-col-12 md-col-8 mx-auto mw7'>
          <h1 className='coll-name m0 h0'>{coll.name}</h1>
          {!_.isEmpty(coll.description) ? <p className='h3 mt1 mb0 coll-desc'>{coll.description}</p> : null}
          {this.props.pub ?
            <p className='mt1 mb1 coll-desc h4'>Published by {coll.publisher}</p>
          : null}
          <div className={actionsClass}>
            {this.props.edit ?
              <a name='editCollection' href='#editCollection' className='link-reset' data-behavior='modal_trigger'>Edit · </a>
            : null}
            <a name='shareCollection' href='#shareCollection' className='link-reset' data-behavior='modal_trigger'>Share</a>
          </div>
        </div>
      </header>
    )
  }
}
