import React from 'react'
import PropTypes from 'prop-types'

import CollectionList from './CollectionList'
import ModalLink from './ModalLink'
import SplitLayout from './SplitLayout'

const CollectionsHome = ({ collections, ...props }) => (
  <SplitLayout
    heading="Collections"
    sidebar={
      <ModalLink
        is="btn"
        name="new"
        primary
        color="blue"
        children="New collection"
      />
    }
    content={<CollectionList collections={collections} className="phm" />}
  />
)

CollectionsHome.propTypes = {
  collections: PropTypes.array.isRequired
}

export default CollectionsHome
