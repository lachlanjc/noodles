class CollectionIndex extends React.Component {
  propTypes: {
    collections: React.PropTypes.array.isRequired
  }

  render() {
    return (
      <main className='md-col-9 mx-auto pam tc'>
        <h1 className='tc'>Collections</h1>
        {this.renderCollections()}
      </main>
    )
  }

  renderCollections() {
    const collections = this.props.collections;

    if (_.isEmpty(collections)) {
      return (
        <article className='md-col-8 mw6 mx-auto mvm border bg-white rounded pal'>
          <h3 className='mtn mbm'>You don't have any collections yet.</h3>
          <p>Collections help you organize your recipes.</p>
          <p className='mbn'>You can use them for categories, such as salads or pastas, or recipes that might be good for a summer dinner party.</p>
          <a href='#newCollection' className='btn bg-green mtm' data-behavior='modal_trigger'>Create your first collection</a>
        </article>
      );
    } else {
      return _.map(collections, coll => {
        return <CollectionItem coll={coll} key={'coll-' + coll.id} />
      });
    }
  }
}

CollectionIndex.propTypes = {
  collections: React.PropTypes.array.isRequired
}

class CollectionItem extends React.Component {
  render() {
    const coll = this.props.coll;
    let imgClass, img;
    if (!_.isEmpty(coll.photo_url)) {
      imgClass = 'image-header bg-center bg-no-repeat bg-cover';
      img = `url(${coll.photo_url.toString()})`;
    } else {
      imgClass = 'bg-white rounded shadow pam';
    }

    return (
      <a href={coll.url} style={{minHeight: '15vh', backgroundImage: img}}
         className={`flex fc fac fjc rounded shadow pal mbm bg-white rounded shadow ${imgClass}`}>
        <h2 className='coll__name man h1 mw7'>{coll.name}</h2>
        {!_.isEmpty(coll.description) ? <h3 className='coll__desc lead man normal mw7'>{coll.description}</h3> : null}
      </a>
    )
  }
}

CollectionItem.propTypes = {
  coll: React.PropTypes.object.isRequired
}
