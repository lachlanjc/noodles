#= require jquery
#= require rails-behaviors
#= require lodash
#= require modals
#= require autosize
#= require clipboard/clipboard
#= require components
#= require global

$(document).ready ->
  # Popover menus
  $(document).on 'click', (e) ->
    o = $(N.openMenuSelector)
    c = $(e.target).closest('[data-behavior~=menu_toggle]')
    if o.length > 0 or c.length > 0
      N.toggleMenu `o.length > 0 ? o : c`
    e.stopImmediatePropagation()
    return
  # Close popover menus on esc
  $(document).keydown (e) ->
    if e.keyCode is 27 and $(N.openMenuSelector).length > 0
      N.toggleMenu $(N.openMenuSelector)

  $(document).on 'click', '[data-behavior~=flash]', ->
    $(this).toggleClass 'bg-white shadow well border'
    $(this).slideUp 'fast'

  activateModals()

  $(document).on 'keydown', 'action, [data-behavior~=r_fav]', (e) ->
    $(this).click() if e.keyCode is 32 or e.keyCode is 13

  $('[data-behavior~=inline_signup_form]').on 'ajaxBeforeSend', ->
    t = $(this)
    t.html null
    t.toggleClass 'busy busy--large mx-auto'
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
    t.toggleClass 'busy busy--large mx-auto bg-darken-1 border rounded pvm mt2 tc'
    $('[data-behavior~=inline_signup_error]').toggleClass 'dn'

  $('[data-behavior~=r_fav_trigger]').on 'change', ->
    $(this)[0].form.submit()
  $(document).on 'click', '[data-behavior~=print]', ->
    window.print()

  if /iPhone|iPad/i.test(navigator.userAgent)
    $('[data-behavior~=copy]').hide()
  clipboard = new Clipboard('[data-behavior~=copy]', text: (trigger) ->
    trigger.getAttribute 'data-clipboard-text'
  )
  clipboard.on 'error', (e) ->
    $btn = $(e.trigger)
    if /Mac/i.test(navigator.userAgent)
      $btn.text 'Press ⌘-C'
    else
      $btn.text 'Press Ctrl-C'
    $btn.on 'mouseleave', (m) ->
      $btn.text 'Copy'
      e.clearSelection()
    return
  clipboard.on 'success', (e) ->
    $btn = $(e.trigger)
    $btn.text 'Copied!'
    reset = -> $btn.text('Copy')
    setTimeout reset, 1500
    e.clearSelection()
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

  # Switch .dn for inline style — prevents flash on load.
  # Eventually (TODO), this should be reusable. Explore needs it as well.
  editorClipContent = $('[data-behavior~=editor_clip_content]')
  editorClipContent.hide().removeClass('dn')
  $(document).on 'click', '[data-behavior~=editor_clip_trigger]', (e) ->
    # Prevent clicking again
    $('[data-behavior~=editor_clip_trigger]').data 'behavior', ''
    $('[data-behavior~=editor_clip_r]').remove()
    editorClipContent.show 'fast'
    h = $('[data-behavior~=editor_clip_header]')
    # Fix margins
    h.toggleClass 'mtn man fwn pointer'
    # Be definitive.
    h.text 'Clip from the Web'
    return
  $('[data-behavior~=autosize]').autosize()
  $('[data-behavior~=editor_instructions]').on 'focus', ->
    this.value = "1. " if _.isEmpty this.value
