import React from 'react'
import PropTypes from 'prop-types'
import Icon from './Icon'

const RecipeListItem = ({ recipe, pub }) => {
  const { title, description, shared_id, path, public_path } = recipe
  const link = pub ? public_path : path

  const feats = {
    collections: 'flag',
    notes: 'post',
    photo: 'photo',
    web: 'link',
    favorite: 'link'
  }
  const icons = []
  _.forEach(_.keys(feats), feat => {
    if (recipe[feat]) {
      icons.push(
        <RecipeListItemIcon
          feat={feats[feat]}
          key={`r-${shared_id}-${_.indexOf(feats, feat)}`}
        />
      )
    }
  })

  return (
    <li className="border-top feel pam">
      <a href={link} className="link-reset">
        <div
          className="fr dn-p"
          style={{ color: '#C0CCDA' }}
          children={icons}
        />
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
  <Icon glyph={feat} size={28} style={{}} className={'mls'} />
)
