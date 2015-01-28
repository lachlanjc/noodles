#= require jquery
#= require jquery_ujs
#= require react
#= require react_ujs
#= require_tree ./components
#= require modals

printRecipe = ->
  toPrint = confirm("Just remember the trees.")
  window.print() if toPrint == true
  return

$(document).ready ->
  if $("#recipeFavoriteTrigger").length > 0
    $("#recipeFavoriteTrigger").click ->
      $("#recipeFavoriteForm").submit()
  $(".modalTrigger").leanModal()
  $("#importModalTrigger").leanModal()
  $("#collectModalTrigger").leanModal()
  $("#shareModalTrigger").leanModal()
  if $("#printRecipe").length > 0
    document.getElementById("printRecipe").addEventListener "click", printRecipe, false
  return
