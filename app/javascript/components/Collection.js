import React from 'react'
import PropTypes from 'prop-types'

import CollectionHeader from './CollectionHeader'
import BlankSlate from './BlankSlate'
import RecipeList from './RecipeList'
import SplitLayout from './SplitLayout'
import RecentlyCooked from './RecentlyCooked'

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
    <CollectionPageContent id={id} recipes={recipes} photo={photo} pub={pub} />
  )
  return (
    <main className={_.isEmpty(photo) && cx}>
      <CollectionHeader edit={edit} pub={pub} coll={collection} />
      {pub
        ? content
        : <SplitLayout
            sidebar={
              <CollectionPageSidebar
                id={collection.id}
                recipes={recipes}
                createdAt={created_at}
                updatedAt={updated_at}
              />
            }
            content={content}
          />}
    </main>
  )
}

CollectionPage.propTypes = {
  collection: PropTypes.object.isRequired,
  edit: PropTypes.bool,
  pub: PropTypes.bool
}

export default CollectionPage

import Button from './Button'
import ModalLink from './ModalLink'
import Spacer from './Spacer'

const CollectionPageSidebar = ({ id, recipes, createdAt, updatedAt }) => (
  <div className="dn-p">
    <ModalLink primary is="btn" name="edit" color="blue" children="Edit" />
    <Spacer x={12} y={16} className="dib db-ns" />
    <ModalLink primary is="btn" name="share" color="purple" children="Share" />
    <Spacer x={12} y={16} className="dib db-ns" />
    <Button
      primary
      color="green"
      href={`/recipes/new?collection=${id}`}
      children="New recipe"
    />
    <p className="grey-3 mtm mbn f5">
      Created on {new Date(createdAt).toLocaleDateString()}
    </p>
    {updatedAt !== createdAt &&
      <p className="grey-3 mtn mbm f5">
        Updated on {new Date(updatedAt).toLocaleDateString()}
      </p>}
    {!_.isEmpty(recipes) && <RecentlyCooked recipes={recipes} />}
  </div>
)

CollectionPageSidebar.propTypes = {
  id: PropTypes.number.isRequired,
  recipes: PropTypes.array,
  createdAt: PropTypes.string,
  updatedAt: PropTypes.string
}

const CollectionPageContent = ({ id, recipes, photo, pub }) =>
  !_.isEmpty(recipes)
    ? <RecipeList
        recipesCore={recipes}
        pub={pub}
        className={!_.isEmpty(photo) && 'document mw7 pan oh mbl'}
      />
    : <CollectionBlankSlate id={id} pub={pub} />

CollectionPageContent.propTypes = {
  id: PropTypes.number.isRequired,
  recipes: PropTypes.array.isRequired,
  photo: PropTypes.string,
  pub: PropTypes.bool
}

const CollectionBlankSlate = ({ id, pub = true }) => (
  <BlankSlate className="bg-white" margin="mvn mln">
    <h3 className="mvn">No recipes in this collection yet.</h3>
    {!pub && [
      <p className="mvm">
        Add an existing recipe from its page, or create a new one.
      </p>,
      <footer className="flex fjc">
        <Button
          color="green"
          href={`/recipes/new?collection=${id}`}
          children="New recipe"
        />
        <Spacer x={16} />
        <Button href="/recipes" color="grey-3" children="Find a recipe" />
      </footer>
    ]}
  </BlankSlate>
)

CollectionBlankSlate.propTypes = {
  id: PropTypes.number.isRequired,
  pub: PropTypes.bool
}
