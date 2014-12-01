#= require jquery
# require turbolinks

showRecipeDetails = ->
  document.getElementById('recipe-details-container').setAttribute 'class', 'show'
  document.getElementById('recipe-details-btn').setAttribute 'class', 'hide'
  return

printRecipe = ->
  toPrint = confirm('Do you really need to print this recipe? If you can, look at it on a screen to save paper.')
  window.print() if toPrint == true
  return

window.onload = ->
  if document.getElementById('recipe-details-btn') != null
    document.getElementById('recipe-details-btn').addEventListener 'click', showRecipeDetails, false
  if document.getElementById('printRecipe') != null
    document.getElementById('printRecipe').addEventListener 'click', printRecipe, false
    return
  return
