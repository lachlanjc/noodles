import WebpackerReact from 'webpacker-react'

import Nav from '../components/Nav'
import FlashContainer from '../components/Flash'
import SuperHeading from '../components/SuperHeading'
import Icon, { AllIcons } from '../components/Icon'

import RecipesHome from '../components/RecipesHome'
import RecipesHomeBlank from '../components/RecipesHomeBlankSlate'
import CollectionsHome from '../components/CollectionsHome'
import CollectionsHomeBlankSlate from '../components/CollectionsHomeBlankSlate'
import CollectionPage from '../components/Collection'
import Groceries from '../components/Groceries'
import GroceriesNew from '../components/GroceriesNew'
import GroceriesPast from '../components/GroceriesPast'

WebpackerReact.setup({
  Nav,
  FlashContainer,
  SuperHeading,
  Icon,
  AllIcons,
  RecipesHome,
  RecipesHomeBlank,
  CollectionsHome,
  CollectionsHomeBlankSlate,
  CollectionPage,
  Groceries,
  GroceriesNew,
  GroceriesPast
})
