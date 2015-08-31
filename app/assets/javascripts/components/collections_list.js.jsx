class CollectionIndex extends React.Component {
  render() {
    return (
      <main className='sm-col-11 md-col-7 mx-auto'>
        <h1 className='center'>Collections</h1>
        <article className='collection-list'>
          {this.props.collections.map(function(collection) {
            return <CollectionItem key={collection.id} data={collection} />;
          })}
          {this.props.collections.length === 0 ?
            <div className='md-col-8 mx-auto mt3 text center border bg-white rounded p3'>
              <h3 className='mt0'>You don't have any collections yet.</h3>
              <p>Collections help you organize your recipes.</p>
              <p>You can use them for categories, such as salads or pastas, or recipes that might be good for a summer dinner party.</p>
              <p><a href='#newCollection' className='btn bg-blue mt2' data-behavior='modal_trigger'>Create your first collection</a></p>
            </div>
          : null}
        </article>
      </main>
    )
  }
}

class CollectionItem extends React.Component {
  render() {
    const photo_url = this.props.data.photo_url;

    let imgClass = ' bg-white rounded shadow p2';
    let imgStyle;
    if (photo_url.length > 0) {
      imgClass = ' coll-w-img bg-center bg-no-repeat bg-cover';
      imgStyle = {
        backgroundImage: 'url(' + photo_url + ')'
      }
    }

    return (
      <a href={this.props.data.url} className='link-reset'>
        <div className={'coll-preview rounded shadow mb2 py3' + imgClass} style={imgStyle}>
          <div className='coll-preview-container center'>
            <h2 className='coll-name m0 h1'>{this.props.data.name}</h2>
            <div className='coll-desc lead'>{this.props.data.description}</div>
          </div>
        </div>
      </a>
    )
  }
}
