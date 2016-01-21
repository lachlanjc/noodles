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

  render() {
    return (
      !_.isEmpty(this.state.coll) ?
        <main>
          <CollectionHeader edit={this.props.edit} pub={this.props.pub} coll={this.state.coll} />
          {!_.isEmpty(this.state.coll.recipes) ?
            <RecipeList recipesCore={this.state.coll.recipes} pub={this.props.pub} className='md-col-8 phm' />
          : this.renderNoRecipes()}
        </main>
      : <h3 className='tc grey-3 pvl'>Loading...</h3>
    )
  }

  renderNoRecipes() {
    return (
      <BlankSlate>
        <h3 className='man'>No recipes in this collection yet.</h3>
        {this.props.pub === false ?
          <div className='mtm'>
            <p>Add recipes by clicking "Add to Collection" at the bottom of any of your recipes.</p>
            <a href='/recipes' className='btn bg-blue'>Find some recipes</a>
          </div>
        : null}
      </BlankSlate>
    )
  }
}

class CollectionHeader extends React.Component {
  componentDidMount() {
    $('[data-behavior~=modal_trigger]').leanModal()
  }

  render() {
    const coll = this.props.coll;

    let rootClass = 'col-12 bs-bb flex fac';
    let rootStyle = {};
    let actionsClass = 'caps h4 dn-p mtm';
    if (!_.isEmpty(coll.photo)) {
      rootClass += ' image-header relative inline-with-nav pvl bg-cover bg-center bg-no-repeat';
      rootStyle.backgroundImage = `url(${coll.photo_url})`;
      actionsClass += ' mbm db white';
    } else {
      rootClass += ' tc grey-4 pvm';
    }

    return (
      <header className={rootClass} style={{backgroundImage: `url(${coll.photo})`}}>
        <div className='sm-col-12 md-col-8 mx-auto phm mw7'>
          <h1 className='coll__name man h0'>{coll.name}</h1>
          {!_.isEmpty(coll.description) ? <p className='h3 mts mbn coll__desc'>{coll.description}</p> : null}
          {this.props.pub ?
            <p className='mvs coll__desc h4'>Published by {coll.publisher}</p>
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
