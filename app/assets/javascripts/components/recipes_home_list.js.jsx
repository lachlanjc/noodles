
const RecipesHomeList = ({
  recipes
}) => (
  <Document
    mw={7}
    className='card pan oh'
    style={{
      height: 'intrinsic',
      borderRadius: 10
    }}
  >
    <RecipeList
      recipesCore={recipes}
      pub={false}
      createFromSearch
      searchCommands
      >
      <RecipeListComplication
        href={_.sample(_.map(recipes, _.property('path')))}
        icon='lightbulb'
        tooltip='Open a random recipe'
      />
    </RecipeList>
    <ProTip />
  </Document>
)

RecipesHomeList.propTypes = {
  recipes: React.PropTypes.array.isRequired
}
