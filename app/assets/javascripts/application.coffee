#= require jquery
#= require jquery_ujs
#= require react
#= require react_ujs
#= require_tree ./components
#= require zeroclipboard
#= require modals

$(document).ready ->
  $('[data-behavior~=flash]').on 'click', ->
    $(this).toggleClass('bg-white shadow well border')
    $(this).slideUp('fast')
  $('[data-behavior~=recipe_favorite_trigger]').on 'change', ->
    $(this)[0].form.submit()
    return
  $('.js-modal-trigger').leanModal()
  $('[data-behavior~=print]').on 'click', ->
    window.print()
    return
