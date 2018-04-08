import React from 'react'
import PropTypes from 'prop-types'

import CollectionList from './CollectionList'
import ModalLink from './ModalLink'
import Icon from './Icon'
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
        className="flex-i fac"
      >
        <Icon glyph="plus" size={28} />
        <span>New collection</span>
      </ModalLink>
    }
    content={<CollectionList collections={collections} className="phm" />}
  />
)

CollectionsHome.propTypes = {
  collections: PropTypes.array.isRequired
}

export default CollectionsHome
