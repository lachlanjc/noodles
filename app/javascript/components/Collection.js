import React from 'react'
import PropTypes from 'prop-types'

import CollectionHeader from './CollectionHeader'
import CollectionSidebar from './CollectionSidebar'
import CollectionContent from './CollectionContent'
import SplitLayout from './SplitLayout'

const CollectionPage = ({ collection, edit = false, pub = false }) => {
  const {
    id,
    shared_id,
    user_id,
    name,
    description,
    photo,
    recipes,
    created_at,
    updated_at
  } = collection
  const content = (
    <CollectionContent id={id} recipes={recipes} photo={photo} pub={pub} />
  )
  return (
    <main className={_.isEmpty(photo) && cx}>
      <CollectionHeader edit={edit} pub={pub} coll={collection} />
      {pub ? (
        content
      ) : (
        <SplitLayout
          sidebar={
            <CollectionSidebar
              id={collection.id}
              recipes={recipes}
              createdAt={created_at}
              updatedAt={updated_at}
            />
          }
          content={content}
          className="phn phl-ns"
        />
      )}
    </main>
  )
}

CollectionPage.propTypes = {
  collection: PropTypes.object.isRequired,
  edit: PropTypes.bool,
  pub: PropTypes.bool
}

export default CollectionPage
