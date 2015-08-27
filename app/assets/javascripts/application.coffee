#= require jquery
#= require jquery_ujs
#= require react
#= require react_ujs
#= require_tree ./components
#= require zeroclipboard
#= require modals
#= require autosize

$(document).ready ->
  $('[data-behavior~=flash]').on 'click', ->
    $(this).toggleClass('bg-white shadow well border')
    $(this).slideUp('fast')
  $('[data-behavior~=modal_trigger]').leanModal()
  $('[data-behavior~=recipe_favorite_trigger]').on 'change', ->
    $(this)[0].form.submit()
  $('[data-behavior~=print]').on 'click', ->
    window.print()
  $('[data-behavior~=autosize]').autosize()
  $('[data-behavior~=photo_button]').on 'click', ->
    $('[data-behavior~=photo_field]').click()
  $('[data-behavior~=photo_field]').on 'change', ->
    $('[data-behavior~=photo_name]').text(this.value.match(/[^\/\\]+$/)[0])
  $('[data-behavior~=cook_photo_field]').on 'change', ->
    $(this)[0].form.submit()
  $('[data-behavior~=editor_instructions]').on 'focus', ->
    this.value = "1. " if this.value.length == 0
  return
