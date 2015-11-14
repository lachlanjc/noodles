#= require jquery
#= require rails-behaviors
#= require react
#= require react_ujs
#= require lodash/lodash
#= require zeroclipboard
#= require modals
#= require autosize
#= require signup
#= require_tree ./components

$(document).ready ->
  $(document).on 'click', '[data-behavior~=flash]', ->
    $(this).toggleClass 'bg-white shadow well border'
    $(this).slideUp 'fast'

  $('[data-behavior~=recipe_favorite_trigger]').on 'change', ->
    $(this)[0].form.submit()
  $(document).on 'click', '[data-behavior~=print]', ->
    window.print()

  $(document).on 'click', '[data-behavior~=photo_name]', ->
    $('[data-behavior~=photo_field]').click()
  $('[data-behavior~=photo_field]').on 'change', ->
    $('[data-behavior~=photo_name]').text this.value.match(/[^\/\\]+$/)[0]
    $('[data-behavior~=recipe_errors]').hide 400
  $(document).on 'click', '[data-behavior~=remove_current_photo]', ->
    l = $(this).find('[data-behavior~=remove_current_photo_link]')
    l.text 'Removing photo...'
    l.click()
    $('[data-behavior~=recipe_errors]').hide 400
  $(document).on 'ajaxSuccess', '[data-behavior~=remove_current_photo_link]', ->
    t = $(this)
    t.text 'Removed!'
    $('[data-behavior~=photo_name]').text 'Upload a new photo'
    t.parent().hide 400

  $('[data-behavior~=cook_photo_field]').on 'change', ->
    $(this)[0].form.submit()

  $(document).on 'click', '[data-behavior~=checklist_item]', ->
    $(this).toggleClass 'checked'

  $('[data-behavior~=autosize]').autosize()
  $('[data-behavior~=editor_instructions]').on 'focus', ->
    this.value = "1. " if _.isEmpty this.value
