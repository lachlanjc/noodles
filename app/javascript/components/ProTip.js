import React from 'react'
import Icon from './Icon'

const tips = [
  'Create a new recipe super quickly by searching with its title.',
  'Tap the lightbulb icon next to search for a random recipe.',
  'Use Cook Mode to check off ingredients as you cook.',
  'Tap the heart icon to mark recipes as Favorites and find them faster.',
  'Save recipes from the web with the Import button.',
  'Share a recipe with anyone from the menu on the recipe page.',
  'Download a PDF of a recipe from the menu on the recipe page.',
  'Get quick access to recipes you’ve cooked recently in the sidebar.',
  'Get quick access to your Grocery List in the sidebar.',
  'Use the font size controls to enlarge text in Cook Mode.',
  'Hover an ingredient and click the button to add it to your Grocery List.',
  'Try adding ingredients to your Grocery List over SMS.',
  'What could be better about Noodles? Tap the Feedback tab and let me know.'
]

const ProTip = () => (
  <footer
    className="border-top flex fac fjc dn-p"
    style={{
      paddingTop: 8,
      paddingBottom: 12,
      paddingLeft: 12,
      paddingRight: 12
    }}
  >
    <Icon glyph="emoji" size={28} className="dib grey-3 mrs relative" />
    <strong style={{ marginRight: 6 }}>ProTip!</strong>
    <span children={tips[_.random(0, tips.length - 1)]} />
  </footer>
)

export default ProTip
