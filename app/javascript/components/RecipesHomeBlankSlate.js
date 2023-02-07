import React from 'react'

import RecipesHomeSidebar from './RecipesHomeSidebar'
import SplitLayout from './SplitLayout'
import Document from './Document'

const RecipesHomeBlank = () => (
  <SplitLayout
    className="pvm phl-ns"
    heading="Recipes"
    sidebar={<RecipesHomeSidebar hideModules />}
    content={<RecipesHomeBlankSlate />}
  />
)

const RecipesHomeBlankSlate = () => (
  <article>
    <h2 className="f1 mtm mbs orange">Let’s get cooking!</h2>
    <p className="sans grey-3 f2">
      Noodles is a place to keep your recipes. So let’s add your first few
      recipes.
    </p>
    <ol
      className="list-reset relative mtl mbl"
      style={{
        display: 'grid',
        gridTemplateColumns: 'repeat(auto-fit, minmax(14rem, 1fr))',
        gridGap: 24
      }}
    >
      <li className="card pam">
        <h3 className="mvn">Trying to find a new recipe?</h3>
        <p className="mvn grey-2">
          Tap <span className="orange b sans">Explore</span> at the top to find
          a recipe on the web via Noodles.
        </p>
      </li>
      <li className="card pam">
        <h3 className="mvn">Already have a recipe?</h3>
        <p className="mvn grey-2">
          In the sidebar, tap <span className="blue b sans">New recipe</span> to
          write in a recipe yourself, or{' '}
          <span className="yellow b sans">Import</span> to save a web recipe.
        </p>
      </li>
    </ol>
    <p class="grey-2">
      <strong>Have any questions?</strong> Tap “Help & feedback” in the corner
      of any page & I’ll help you out 🧡
    </p>
  </article>
)

export default RecipesHomeBlank
