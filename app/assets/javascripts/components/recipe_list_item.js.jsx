
const RecipeListItem = ({ recipe, pub }) => {
  const link = pub ? recipe.public_path : recipe.path

  const feats = ['collections', 'notes', 'photo', 'web', 'favorite']
  let icns = []
  _.forEach(feats, feat => {
    if (recipe[feat]) {
      icns.push(
        <RecipeListItemIcon
          feat={feat}
          key={`r-${recipe.shared_id}-${_.indexOf(feats, feat)}`}
        />
      )
    }
  })

  const { title, description } = recipe

  return (
    <li className='border-top feel pam'>
      <a href={link} className='link-reset'>
        <div className='fr dn-p'>{icns}</div>
        <h3 className='man' children={title} />
        <p className='man text truncate grey-3'>{description}</p>
      </a>
    </li>
  )
}

const RecipeListItemIcon = ({ feat }) =>
  <Icon
    icon={feat === 'favorite' ? 'fav' : feat}
    className={`mls ${feat === 'favorite' ? 'fill-orange' : 'fill-grey-4'}`}
  />

RecipeListItem.propTypes = {
  recipe: React.PropTypes.object.isRequired,
  pub: React.PropTypes.bool
}
