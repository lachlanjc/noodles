#= require jquery
#= require modals
# require turbolinks

printRecipe = ->
  toPrint = confirm("Do you really need to print this out? If you can, look at it on a mobile device or laptop to save paper.")
  window.print() if toPrint == true
  return

window.onload = ->
  if document.getElementById("recipeFavoriteTrigger") != null
    $("#recipeFavoriteTrigger").click ->
      $("#recipeFavoriteForm").submit()
      return
  $(document).ready ->
    if document.getElementById("importModalTrigger") != null
      $("#importModalTrigger").leanModal()
    if document.getElementById("shareModalTrigger") != null
      $("#shareModalTrigger").leanModal()
  if document.getElementById("printRecipe") != null
    document.getElementById("printRecipe").addEventListener "click", printRecipe, false
  return
