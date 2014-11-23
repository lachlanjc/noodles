#= require jquery
# require turbolinks

@showRecipeDetails = ->
  document.getElementById('recipe-details-container').setAttribute 'class', 'show'
  document.getElementById('recipe-details-btn').setAttribute 'class', 'hide'
  return

window.onload = ->
  if document.getElementById('recipe-details-btn') != null
    document.getElementById('recipe-details-btn').addEventListener 'click', @showRecipeDetails, false
    return
  return
