import React from 'react'
import PropTypes from 'prop-types'

const CollectionListItem = ({ coll }) => {
  const { path, photo, name, description } = coll
  const sx = {
    boxSizing: 'border-box',
    display: 'flex',
    flexDirection: 'column',
    justifyContent: 'center',
    backgroundImage: `url('${photo}')`,
    width: '100%'
  }

  const img = `url(${photo})`
  const desc = !_.isEmpty(description)

  return (
    <article className="card pan flex-grid__item flex">
      <a
        href={path}
        style={sx}
        className={`pam pvl rounded image-header bg-center bg-no-repeat bg-cover`}
      >
        <h2 className="f1 white mtn mbs">{name}</h2>
        {desc && (
          <p className="f3 white lh-title mvn wbw" children={description} />
        )}
      </a>
    </article>
  )
}

export default CollectionListItem

CollectionListItem.propTypes = {
  coll: PropTypes.object.isRequired
}
