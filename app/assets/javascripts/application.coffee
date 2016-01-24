#= require jquery
#= require rails-behaviors
#= require lodash
#= require modals
#= require autosize
#= require clipboard/clipboard
#= require components

$(document).ready ->
  $(document).on 'click', '[data-behavior~=flash]', ->
    $(this).toggleClass 'bg-white shadow well border'
    $(this).slideUp 'fast'

  activateModals()

  $('[data-behavior~=inline_signup_form]').on 'ajaxBeforeSend', ->
    t = $(this)
    t.html null
    t.toggleClass 'busy busy-large mx-auto'
    t.find('[data-behavior~=hide_on_inline_submit]').hide()
  $(document).on 'ajaxSuccess', '[data-behavior~=inline_signup_form]', ->
    t = $(this)
    if b = $('[data-behavior~=inline_signup_btn]')
      b.blur()
      b.hide()
      b.parent().append '<p class="blue b">Signed up! Thanks 😊</p>'
    t.closest('.modal').find('[data-behavior~=modal_close]').click()
    u = window.location.pathname
    if !_.isEmpty u.match 'explore'
      r = -> location.reload()
    else
      r = -> window.location = '/onboarding'
    setTimeout r, 600
  $(document).on 'ajaxError', '[data-behavior~=inline_signup_form]', ->
    t = $(this)
    t.toggleClass 'busy busy-large mx-auto bg-darken-1 border rounded pvm mt2 tc'
    $('[data-behavior~=inline_signup_error]').toggleClass 'dn'

  $('[data-behavior~=recipe_favorite_trigger]').on 'change', ->
    $(this)[0].form.submit()
  $(document).on 'click', '[data-behavior~=print]', ->
    window.print()

  if /iPhone|iPad/i.test(navigator.userAgent)
    $('[data-behavior~=copy]').hide()
  clipboard = new Clipboard('[data-behavior~=copy]', text: (trigger) ->
    trigger.getAttribute 'data-clipboard-text'
  )
  clipboardTooltip = ($btn, text) ->
    if text.length > 0
      $btn.attr 'aria-label', text
      $btn.addClass 'tooltipped tooltipped--n'
    else
      $btn.removeClass 'tooltipped tooltipped--n'
    return true
  clipboardSuccess = (e) ->
    $btn = $(e.trigger)
    clipboardTooltip $btn, 'Copied!'
    setTimeout clipboardTooltip($btn, ''), 1200
    e.clearSelection()
  clipboard.on 'error', (e) ->
    $btn = $(e.trigger)
    if /Mac/i.test(navigator.userAgent)
      clipboardTooltip $btn, 'Press ⌘-C'
    else
      clipboardTooltip $btn, 'Press Ctrl-C'
    $btn.on 'mouseleave', (m) ->
      clipboardTooltip($btn, '')
      e.clearSelection()
    return
  clipboard.on 'success', (e) ->
    clipboardSuccess(e)
    return

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
