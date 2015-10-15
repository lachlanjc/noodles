class CollectionIndex extends React.Component {
  render() {
    return (
      <main className='md-col-9 mx-auto phm'>
        <h1 className='tc'>Collections</h1>
        <article>
          {this.props.collections.map(function(collection) {
            return <CollectionItem key={collection.id} coll={collection} />;
          })}
          {_.isEmpty(this.props.collections) ?
            <div className='md-col-8 mx-auto mtm text tc border bg-white rounded pal'>
              <h3 className='mt0'>You don't have any collections yet.</h3>
              <p>Collections help you organize your recipes.</p>
              <p className='mb0'>You can use them for categories, such as salads or pastas, or recipes that might be good for a summer dinner party.</p>
              <a href='#newCollection' className='btn bg-blue mtm' data-behavior='modal_trigger'>Create your first collection</a>
            </div>
          : null}
        </article>
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
