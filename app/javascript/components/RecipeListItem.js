import React from 'react'
import PropTypes from 'prop-types'
import Icon, { CollectionsIcon } from './Icon'

const RecipeListItemIcon = props => (
  <Icon size={28} className="mls" {...props} />
)

const RecipeListItem = ({ recipe, pub }) => {
  const { title, description, shared_id, path, public_path } = recipe
  const link = pub ? public_path : path

  return (
    <li className="border-top feel pam">
      <a href={link} className="link-reset">
        <div className="fr dn-p" style={{ color: '#C0CCDA' }}>
          {recipe.collections && <CollectionsIcon size={28} className="mls" />}
          {recipe.notes && <RecipeListItemIcon glyph="post" />}
          {recipe.photo && <RecipeListItemIcon glyph="photo" />}
          {recipe.web && <RecipeListItemIcon glyph="link" />}
          {recipe.favorite && (
            <RecipeListItemIcon glyph="like-fill" className="mls pink" />
          )}
        </div>
        <h3 className="man" children={title} />
        <p className="man text truncate grey-3">{description}</p>
      </a>
    </li>
  )
}

RecipeListItem.propTypes = {
  recipe: PropTypes.object.isRequired,
  pub: PropTypes.bool
}

export default RecipeListItem
