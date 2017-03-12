#= require react
#= require react_ujs

#= require components/blankslate
#= require components/button
#= require components/collection
#= require components/collection_header
#= require components/collection_list
#= require components/collection_list_item
#= require components/collections_home
#= require components/collections_home_blank_slate
#= require components/collections_mini
#= require components/document
#= require components/flash
#= require components/icon
#= require components/modal
#= require components/modal_link
#= require components/protip
#= require components/recipe_list
#= require components/recipe_list_complication
#= require components/recipe_list_item
#= require components/recipes_home
#= require components/recipes_home_blank_slate
#= require components/recipes_home_list
#= require components/recipes_home_sidebar
#= require components/search_bar
#= require components/section_header
#= require components/spacer
#= require components/split_layout
#= require components/super_header

# HACK so Uglifier doesn't remove names of components called with view helper
console.log 'React Components', RecipesHome, RecipesHomeBlankSlate, CollectionsHome, CollectionPage, FlashContainer
