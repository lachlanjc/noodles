import React from 'react'

import RecipesHomeSidebar from './RecipesHomeSidebar'
import SplitLayout from './SplitLayout'

const RecipesHomeBlank = () => (
  <SplitLayout
    className="pvm phl-ns"
    heading="Recipes"
    sidebar={<RecipesHomeSidebar hideModules />}
    content={<RecipesHomeBlankSlate />}
  />
)

const css = `
@media screen and (min-width: 64em) {
  .onboarding__prompt {
    position: absolute;
    top: 66%;
    left: 0;
    display: flex;
    justify-content: center;
  }

  .onboarding__prompt__message {
    margin-top: 0;
    padding-top: 2.5rem;
  }

  .onboarding__prompt__arrow {
    display: inline-block;
    position: relative;
    left: -.5rem;
  }
}
`

const RecipesHomeBlankSlate = () => (
  <article className="phm mw8 mx-auto tc">
    <h2 className="f1 mtn mbs grey-2">
      Let’s get cooking!
    </h2>
    <ol className="flex-grid fjc list-reset relative tl">
      <div className="onboarding__prompt flex-grid__item dn">
        <p className="onboarding__prompt__message tc orange b">
          Try Explore first!
        </p>
        <svg
          className="onboarding__prompt__arrow dn fill-orange"
          width="24"
          height="60"
          viewBox="0 0 24 60"
          xmlns="http://www.w3.org/2000/svg"
        >
          <path
            d="M8.633 6.695c6.86 12.419 11.75 25.539 14.207 39.496.45 2.413.902 4.826 1.107 7.265.145 1.672-.038 3.342-.166 5.012-.077.959-.95 1.611-1.91 1.524-.931-.114-1.702-.83-1.598-1.761.868-6.927-1.14-13.567-2.49-20.258C15.76 28.1 11.985 18.876 6.98 10.166c-.69-1.182-1.464-2.282-2.21-3.409-.165-.22-.357-.413-.605-.66.281 1.48.59 2.879.79 4.277.142 1.124-.456 1.943-1.415 2.02-.958.077-1.592-.666-1.79-1.736C1.44 9.041.968 7.477.576 5.886.407 5.282.213 4.706.1 4.102-.35 1.744.737.271 3.12.037c2.984-.231 5.728.66 8.446 1.797 1.043.444 2.005 1.025 3.021 1.496.577.25 1.208.444 1.811.557 1.07.197 1.814.996 1.71 1.981-.105.986-.896 1.722-1.965 1.524-1.042-.17-2.03-.504-2.991-.92-1.73-.748-3.378-1.634-5.08-2.41-.33-.056-.659-.113-1.153-.28.664 1.1 1.216 1.98 1.714 2.913z"
            fillRule="evenodd"
          />
        </svg>
        <style children={css} />
      </div>
      <li className="flex-grid__item bg-white rounded shadow pam">
        <h3 className="mvn orange">Explore</h3>
        <p className="mvn grey-2">
          Find and save great recipes from around the web.
        </p>
        <p
          className="mts mbn dn-ns orange b"
          style={{
            fontStyle: 'italic'
          }}
        >
          → Start here!
        </p>
      </li>
      <li className="flex-grid__item bg-white rounded shadow pam">
        <h3 className="mvn purple">Import</h3>
        <p className="mvn grey-2">Paste in a URL to import from the web.</p>
      </li>
      <li className="flex-grid__item bg-white rounded shadow pam">
        <h3 className="mvn blue">Write</h3>
        <p className="mvn grey-2">Type or paste in a recipe yourself.</p>
      </li>
    </ol>
    <p className="mtm mtl-ns grey-3">
      Later: start filling your
      {' '}
      <a href="/groceries" className="blue">Grocery List</a>
    </p>
  </article>
)

export default RecipesHomeBlank
