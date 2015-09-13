#= require jquery
#= require jquery_ujs
#= require react
#= require react_ujs
#= require lodash/lodash
#= require zeroclipboard
#= require modals
#= require autosize
#= require_tree ./components

$(document).ready ->
  $('[data-behavior~=flash]').on 'click', ->
    $(this).toggleClass('bg-white shadow well border')
    $(this).slideUp('fast')

  $('[data-behavior~=modal_trigger]').leanModal()

  $('[data-behavior~=recipe_favorite_trigger]').on 'change', ->
    $(this)[0].form.submit()
  $('[data-behavior~=print]').on 'click', ->
    window.print()

  $('[data-behavior~=photo_name]').on 'click', ->
    $('[data-behavior~=photo_field]').click()
  $('[data-behavior~=photo_field]').on 'change', ->
    $('[data-behavior~=photo_name]').text(this.value.match(/[^\/\\]+$/)[0])
  $('[data-behavior~=cook_photo_field]').on 'change', ->
    $(this)[0].form.submit()

  $('[data-behavior~=checklist_item]').on 'click', ->
    $(this).toggleClass('checked')

  $('[data-behavior~=autosize]').autosize()
  $('[data-behavior~=editor_instructions]').on 'focus', ->
    this.value = "1. " if this.value.length == 0
