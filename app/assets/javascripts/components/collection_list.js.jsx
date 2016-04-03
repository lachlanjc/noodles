class CollectionList extends React.Component {
  render() {
    return (
      <main className='md-col-9 mx-auto pam tc'>
        <h1 className='tc mtn mbm'>Collections</h1>
        {this.renderCollections()}
      </main>
    )
  }

  renderBlankSlate() {
    return (
      <article className='md-col-8 mw6 mx-auto mvm border bg-white rounded pal'>
        <h3 className='mtn mbm'>You don't have any collections yet.</h3>
        <p>Collections help you organize your recipes.</p>
        <p className='mbn'>
          You can use them for categories, such as salads or pastas, or recipes that might be good for a summer dinner party.
        </p>
        <a href='#newCollection' className='btn bg-green mtm' data-behavior='modal_trigger'>Create your first collection</a>
      </article>
    )
  }

  renderCollections() {
    const colls = this.props.collections

    if (_.isEmpty(colls)) { return ( this.renderBlankSlate() ) }

    return _.map(colls, coll => {
      return <CollectionListItem coll={coll} key={'coll-' + coll.id} />
    })
  }
}

CollectionList.propTypes = {
  collections: React.PropTypes.array.isRequired
}
