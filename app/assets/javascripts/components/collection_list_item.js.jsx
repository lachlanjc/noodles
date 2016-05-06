class CollectionListItem extends React.Component {
  render() {
    const coll = this.props.coll
    let imgClass, img
    if (!_.isEmpty(coll.photo_url)) {
      imgClass = 'image-header bg-center bg-no-repeat bg-cover'
      img = `url(${coll.photo_url.toString()})`
    }

    return (
      <a href={coll.url} style={{minHeight: '15vh', backgroundImage: img}}
         className={`flex fc fac fjc rounded shadow shadow--effect pal mbm bg-white ${imgClass}`}>
        <h2 className='coll__name f1 mw7 mbm'>{coll.name}</h2>
        {!_.isEmpty(coll.description) ?
          <h3 className='coll__desc lead man normal mw7'>{coll.description}</h3>
        : null}
      </a>
    )
  }
}

CollectionListItem.propTypes = {
  coll: React.PropTypes.object.isRequired
}
