import React from 'react'
import PropTypes from 'prop-types'

const CollectionHeader = ({ coll, pub }) => (
  <header
    className="w-100 bx flex fac db mtm mbn image-header white relative inline-with-nav pvl bg-cover bg-center bg-no-repeat"
    style={{
      backgroundImage: `url('${coll.photo}')`
    }}
  >
    <main className="w-100 mw6 mx-auto tc pam">
      <h1 className="coll__name c--inherit mvn f0">
        {coll.name}
      </h1>
      {!_.isEmpty(coll.description) &&
        <p className="c--inherit f3 mvn">{coll.description}</p>}
      <p className="c--inherit o-80 mtm">
        {coll.recipes.length === 1
          ? '1 recipe'
          : `${coll.recipes.length} recipes`}
      </p>
      {pub &&
        <p className="c--inherit o-80 mvs">
          Published by {coll.publisher}
        </p>}
    </main>
  </header>
)

CollectionHeader.propTypes = {
  coll: PropTypes.object.isRequired,
  edit: PropTypes.bool,
  pub: PropTypes.bool
}

export default CollectionHeader
