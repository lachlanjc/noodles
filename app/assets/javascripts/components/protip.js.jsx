
const tips = [
  'Create a new recipe super quickly by searching with its title.',
  'Find a random recipe with the die icon next to search.',
  'Use Cook Mode to check off ingredients as you cook.',
  'Mark recipes as favorites with the star for quick access.',
  'Save recipes from the web with the Clip icon in the right corner.',
  'Share a recipe with anyone from the menu on the recipe page.',
  'Download a PDF of a recipe from the menu on the recipe page.',
]

const ProTip = () => {
  const tip = tips[_.random(0,1)]
  return (
    <footer className='tc'>
      <Icon
        icon='bolt'
        className='dib fill-grey-3 mrs relative'
        style={{ top: 6 }}
      />
      <strong
        style={{ marginRight: 4 }}
        children='ProTip!'
      />
      {tip}
    </footer>
  )
}
