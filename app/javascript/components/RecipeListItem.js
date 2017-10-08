import React from 'react'
import PropTypes from 'prop-types'
import Icon from './Icon'

const RecipeListItem = ({ recipe, pub }) => {
  const { title, description, shared_id, path, public_path } = recipe
  const link = pub ? public_path : path

  const feats = ['collections', 'notes', 'photo', 'web', 'favorite']
  let icns = []
  _.forEach(feats, feat => {
    if (recipe[feat]) {
      icns.push(
        <RecipeListItemIcon
          feat={feat}
          key={`r-${shared_id}-${_.indexOf(feats, feat)}`}
        />
      )
    }
  })

  return (
    <li className="border-top feel pam">
      <a href={link} className="link-reset">
        <div className="fr dn-p">{icns}</div>
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

const RecipeListItemIcon = ({ feat }) => (
  <Icon
    icon={feat === 'favorite' ? 'fav' : feat}
    className={`mls ${feat === 'favorite' ? 'fill-orange' : 'fill-grey-4'}`}
  />
)
