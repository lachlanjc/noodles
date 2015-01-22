#= require jquery
#= require jquery_ujs
#= require jquery.turbolinks
#= require modals
#= require turbolinks

printRecipe = ->
  toPrint = confirm("Just remember the trees.")
  window.print() if toPrint == true
  return

$(document).ready ->
  if document.getElementById("recipeFavoriteTrigger") != null
    $("#recipeFavoriteTrigger").click ->
      $("#recipeFavoriteForm").submit()
  $(document).ready ->
    if document.getElementById("importModalTrigger") != null
      $("#importModalTrigger").leanModal()
    if document.getElementById("shareModalTrigger") != null
      $("#shareModalTrigger").leanModal()
  if document.getElementById("printRecipe") != null
    document.getElementById("printRecipe").addEventListener "click", printRecipe, false
  return
