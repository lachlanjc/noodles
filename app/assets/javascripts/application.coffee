#= require jquery
#= require rails-behaviors
#= require react
#= require react_ujs
#= require lodash/lodash
#= require zeroclipboard
#= require modals
#= require autosize
#= require_tree ./components

$(document).ready ->
  $(document).on 'click', '[data-behavior~=flash]', ->
    $(this).toggleClass('bg-white shadow well border')
    $(this).slideUp('fast')

  $('[data-behavior~=modal_trigger]').leanModal()

  $('[data-behavior~=inline_signup_form]').on 'ajaxBeforeSend', ->
    t = $(this)
    t.html null
    t.toggleClass 'busy busy-large mx-auto'
    t.find('[data-behavior~=hide_on_inline_submit]').hide()
  $(document).on 'ajaxSuccess', '[data-behavior~=inline_signup_form]', ->
    t = $(this)
    t.closest('.modal').find('[data-behavior~=modal_close]').click()
    if b = $('[data-behavior~=inline_signup_btn]')
      b.hide()
      b.parent().append('<p class="blue bold">Signed up! Thanks.</p>')
    r = location.reload()
    setTimeout r, 600
  $(document).on 'ajaxError', '[data-behavior~=inline_signup_form]', ->
    t = $(this)
    t.toggleClass 'busy busy-large mx-auto bg-darken-1 border rounded py2 mt2 center'
    t.html '<p class="h3 red center">Something went wrong.</p><a href="/signup" class="btn bg-blue">Try Again</a>'

  $('[data-behavior~=recipe_favorite_trigger]').on 'change', ->
    $(this)[0].form.submit()
  $(document).on 'click', '[data-behavior~=print]', ->
    window.print()

  $(document).on 'click', '[data-behavior~=photo_name]', ->
    $('[data-behavior~=photo_field]').click()
  $('[data-behavior~=photo_field]').on 'change', ->
    $('[data-behavior~=photo_name]').text this.value.match(/[^\/\\]+$/)[0]
  $(document).on 'click', '[data-behavior~=remove_current_photo]', ->
    l = $(this).find('[data-behavior~=remove_current_photo_link]')
    l.click()
    l.text 'Removing photo...'
  $(document).on 'ajaxSuccess', '[data-behavior~=remove_current_photo_link]', ->
    t = $(this)
    t.text 'Removed!'
    $('[data-behavior~=photo_name]').text 'Upload a new photo'
    t.parent().hide 'slow'

  $('[data-behavior~=cook_photo_field]').on 'change', ->
    $(this)[0].form.submit()

  $(document).on 'click', '[data-behavior~=checklist_item]', ->
    $(this).toggleClass('checked')

  $('[data-behavior~=autosize]').autosize()
  $('[data-behavior~=editor_instructions]').on 'focus', ->
    this.value = "1. " if this.value.length == 0
