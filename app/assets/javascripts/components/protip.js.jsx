
const tips = [
  'Create a new recipe super quickly by searching with its title.',
  'Tap the lightbulb icon next to search for a random recipe.',
  'Use Cook Mode to check off ingredients as you cook.',
  'Mark recipes as favorites with the star for quick access.',
  'Save recipes from the web with the Clip icon in the right corner.',
  'Share a recipe with anyone from the menu on the recipe page.',
  'Download a PDF of a recipe from the menu on the recipe page.'
]

const ProTip = () => {
  const tip = tips[_.random(0, tips.length - 1)]
  return (
    <footer
      className='border-top dn-p'
      style={{
        paddingTop: 8,
        paddingBottom: 12,
        paddingLeft: 12,
        paddingRight: 12,
        textAlign: 'center'
      }}
    >
      <Icon
        icon='bolt'
        className='dib fill-grey-3 mrs relative'
        style={{ top: 6 }}
      />
      <strong>ProTip—</strong>
      <span>{tip}</span>
    </footer>
  )
}
