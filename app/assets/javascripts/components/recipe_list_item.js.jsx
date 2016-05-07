class RecipeListItem extends React.Component {
  render() {
    const recipe = this.props.recipe
    const recipeLink = this.props.pub === true ? recipe.shared_url : recipe.url

    let icns = [];
    _.forEach(['collections', 'notes', 'photo', 'web'], function (feature) {
      if (recipe[feature] === true) {
        icns.push(<Icon icon={feature} className='mls fill-grey-4' />)
      }
    })
    recipe.favorite === true ? icns.push(<Icon icon='fav' className='mls fill-orange' />) : null

    return (
      <li className='bg-white rounded shadow shadow--effect mbs pam'>
        <a href={recipeLink} className='link-reset'>
          <div className='fr dn-p'>{icns}</div>
          <h3 className='man normal'>{recipe.title}</h3>
          <p className='man text'>{recipe.description_preview}</p>
        </a>
      </li>
    )
  }
}

RecipeListItem.propTypes = {
  recipe: React.PropTypes.object.isRequired,
  pub: React.PropTypes.bool
}
