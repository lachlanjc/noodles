#= require jquery
#= require jquery_ujs
#= require react
#= require react_ujs
#= require_tree ./components
#= require modals

$(document).ready ->
  if $("#recipeFavoriteTrigger").length > 0
    $("#recipeFavoriteTrigger").click ->
      $("#recipeFavoriteForm").submit()
  $(".js-modal-trigger").leanModal()
