import React from 'react'
import PropTypes from 'prop-types'

import Button from './Button'
import ModalLink from './ModalLink'
import Spacer from './Spacer'
import RecentlyCooked from './RecentlyCooked'

const CollectionSidebar = ({ id, recipes, createdAt, updatedAt }) => (
  <div className="dn-p">
    <ModalLink primary is="btn" name="edit" color="green" children="Edit" />
    <Spacer x={12} y={16} className="dib db-ns" />
    <ModalLink primary is="btn" name="share" color="purple" children="Share" />
    <Spacer x={12} y={16} className="dib db-ns" />
    <Button
      primary
      color="blue"
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

CollectionSidebar.propTypes = {
  id: PropTypes.number.isRequired,
  recipes: PropTypes.array,
  createdAt: PropTypes.string,
  updatedAt: PropTypes.string
}

export default CollectionSidebar
