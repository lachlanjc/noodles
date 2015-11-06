class CollectionIndex extends React.Component {
  renderCollectionList() {
    return (
      <article>
        {this.props.collections.map(function(collection) {
          return <CollectionItem key={collection.id} coll={collection} />
        })}
      </article>
    )
  }

  renderBlankSlate() {
    return (
      <article className='md-col-8 mw6 mx-auto mtm text tc border bg-white rounded pal'>
        <h3 className='mtn mbm'>You don't have any collections yet.</h3>
        <p>Collections help you organize your recipes.</p>
        <p className='mbn'>You can use them for categories, such as salads or pastas, or recipes that might be good for a summer dinner party.</p>
        <a href='#newCollection' className='btn bg-green mtm' data-behavior='modal_trigger'>Create your first collection</a>
      </article>
    )
  }

  render() {
    return (
      <main className='md-col-9 mx-auto phm'>
        <h1 className='tc'>Collections</h1>
        {!_.isEmpty(this.props.collections) ? this.renderCollectionList() : this.renderBlankSlate()}
      </main>
    )
  }
}

class CollectionItem extends React.Component {
  render() {
    const coll = this.props.coll;

    let imgClass = 'flex fac tc rounded shadow mbm pal';
    let imgStyle = { minHeight: '15vh' };
    if (!_.isEmpty(coll.photo_url)) {
      imgClass += ' image-header bg-center bg-no-repeat bg-cover';
      imgStyle.backgroundImage = `url(${coll.photo_url})`;
    } else {
      imgClass += ' bg-white rounded shadow pam';
    }

    return (
      <a href={coll.url} className={imgClass} style={imgStyle}>
      	<div className='mw7 mx-auto'>
          <h2 className='coll-name man h1'>{coll.name}</h2>
          <div className='coll-desc lead'>{coll.description}</div>
      	</div>
      </a>
    )
  }
}
