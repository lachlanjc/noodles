
const CollectionListItem = ({ coll }) => {
  const { path, photo, name, description } = coll
  const sx = {
    boxSizing: 'border-box',
    display: 'flex',
    flexDirection: 'column',
    justifyContent: 'center',
    alignItems: 'center',
    backgroundImage: `url('${photo}')`,
    width: '100%'
  }

  let img
  let cx = [ 'pam rounded' ]
  if (_.isEmpty(photo)) {
    cx.push('bg-orange white')
  } else {
    cx.push('image-header bg-center bg-no-repeat bg-cover')
    img = `url(${photo.toString()})`
  }
  if (_.isEmpty(description)) {
    cx.push('pvl-ns')
  }

  return (
    <article className='card pan coll flex-grid__item flex'>
      <a
        href={path}
        style={sx}
        className={N.cxs(cx)}
      >
        <h2 className='f1 white mvn'>{name}</h2>
        {!_.isEmpty(description) &&
          <p
            className='f3 white lh-title mvn wbw'
            children={description}
          />
        }
      </a>
    </article>
  )
}

CollectionListItem.propTypes = {
  coll: React.PropTypes.object.isRequired
}
