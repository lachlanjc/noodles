import React from 'react'
import PropTypes from 'prop-types'

import CollectionListItem from './CollectionListItem'

const CollectionList = ({ collections, className, ...props }) => (
  <section className={N.cxs(['flex-grid', className])}>
    {_.map(collections, coll => (
      <CollectionListItem coll={coll} key={`coll-${coll.id}`} />
    ))}
  </section>
)

CollectionList.propTypes = {
  collections: PropTypes.array.isRequired
}

export default CollectionList
