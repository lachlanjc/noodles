
const RecipesHome = ({
  recipes,
  collections
}) =>
  <SplitLayout
    className='pvm phl-ns'
    heading='Recipes'
    sidebar={
      <RecipesHomeSidebar collections={collections} />
    }
    content={
      <RecipesHomeList recipes={recipes} />
    }
  />

RecipesHome.propTypes = {
  recipes: React.PropTypes.array.isRequired,
  collections: React.PropTypes.array
}
