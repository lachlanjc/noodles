#= require jquery
#= require rails-behaviors
#= require lodash
#= require modals
#= require autosize
#= require clipboard/clipboard
#= require components
#= require global

$(document).ready ->
  N.toggleMenu = (m) ->
    $(m).find('[data-behavior~=menu_content]').slideToggle 120
    o = $(m).attr('aria-expanded') is 'true'
    $(m).attr 'aria-expanded', !o
    return

  N.showEditorPhotoPreview = ->
    t = $('[data-behavior~=editor_photo_preview]')
    $('[data-behavior~=modal_overlay]').fadeTo 'fast', 1
    t.css {
      'position': 'absolute',
      'z-index': 10,
    }
    if window.innerWidth > 768
      t.animate {
        'right': '20%',
        'min-width': '16rem',
        'width': '60%',
      }, 300
    else
      t.animate {
        'right': (window.innerWidth - 256) / 2, # 256 = 16px * 16rem
        'width': '16rem',
      }, 300
  N.hideEditorPhotoPreview = ->
    t = $('[data-behavior~=editor_photo_preview]')
    t.css { position: 'initial' }
    t.animate {
      'min-width': t.attr('width'),
      'width': t.attr('width'),
    }, 300, ->
      t.attr 'style', '' # Removes left, right, etc
    $('[data-behavior~=modal_overlay]').fadeTo 'fast', 0, ->
      $(this).css 'display', '' # Removes display: none and clears focus

  # Popover menus
  $(document).on 'click', (e) ->
    o = $(N.openMenuSelector)
    c = $(e.target).closest('[data-behavior~=menu_toggle]')
    if o.length > 0 or c.length > 0
      N.toggleMenu `o.length > 0 ? o : c`
    e.stopImmediatePropagation()
    return
  $(document).keydown (e) ->
    # Close popover menus on esc
    if e.keyCode is 27 and $(N.openMenuSelector).length > 0
      N.toggleMenu $(N.openMenuSelector)
    if e.keyCode is 27 and $('[data-behavior~=editor_photo_preview]').length > 0
      N.hideEditorPhotoPreview()

  $(document).on 'click', '[data-behavior~=flash]', ->
    $(this).toggleClass 'bg-white shadow well border'
    $(this).slideUp 'fast'

  totalModalize()

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
  clipboard = new Clipboard '[data-behavior~=copy]', text: (trigger) ->
    trigger.getAttribute 'data-clipboard-text'
  clipboardReset = (t) ->
    t.toggleClass 'bg-green bg-red' if t.attr('class').match /red/
    t.text 'Copied!'
    r = -> t.text 'Copy'
    setTimeout r, 1500
  clipboard.on 'error', (e) ->
    $btn = $(e.trigger)
    $btn.toggleClass 'bg-green bg-red' unless $btn.attr('class').match /red/
    if /Mac/i.test navigator.userAgent
      $btn.text 'Press ⌘-C'
    else
      $btn.text 'Press Ctrl-C'
    $(document).on 'keyup', (k) ->
      clipboardReset $btn if k.keyCode is 91
    $btn.on 'mouseleave', (m) ->
      $btn.toggleClass 'bg-green bg-red' if $btn.attr('class').match /red/
      $btn.text 'Copy'
      e.clearSelection()
    return
  clipboard.on 'success', (e) ->
    clipboardReset $(e.trigger)
    e.clearSelection()
    return

  # Switch .dn for inline style — prevents flash on load.
  $('[data-behavior~=rehide]').hide().removeClass('dn')

  $(document).on 'click', '[data-behavior~=photo_button]', ->
    $('[data-behavior~=photo_field]').click()
  $('[data-behavior~=photo_field]').on 'change', ->
    d = $('[data-behavior~=photo_button]').find('[data-behavior~=description]')
    d.text this.value.match(/[^\/\\]+$/)[0]
    $('[data-behavior~=recipe_errors]').hide 400
    u = window.URL || window.webkitURL
    if f = document.querySelector('[data-behavior~=photo_field]').files[0]
      r = new FileReader
      r.addEventListener 'load', (->
        $('[data-behavior~=editor_photo]').animate { height: 64 }, 150, ->
          $('[data-behavior~=editor_photo_preview]').attr 'src', r.result
          $('[data-behavior~=editor_photo_cont]').show()
      ), false
      r.readAsDataURL f
  $(document).on 'click', '[data-behavior~=remove_current_photo]', ->
    t = $(this)
    d = t.find('[data-behavior~=description]')
    p = $('[data-behavior~=editor_photo_preview]')
    d.text 'Removing photo...'
    v = 'blur(1px) grayscale(1)'
    p.css { 'filter': v, '-webkit-filter': v }
    $('[data-behavior~=photo_field]').val null
    $.get $(this).data('href'), (e) ->
      d.text 'Removed!'
      $('[data-behavior~=editor_photo_cont]').hide 300, ->
        p.attr 'style', ''
      t.hide 'slow'
    $('[data-behavior~=recipe_errors]').hide 300
  $(document).on 'click', '[data-behavior~=editor_clip_trigger]', (e) ->
    # Prevent clicking again
    $('[data-behavior~=editor_clip_trigger]').data 'behavior', ''
    $('[data-behavior~=editor_clip_r]').remove()
    $('[data-behavior~=editor_clip_content]').show 'fast'
    h = $('[data-behavior~=editor_clip_header]')
    h.toggleClass 'mtn man fwn pointer' # Fix margins
    h.text 'Clip from the Web' # Be definitive.
    return
  # Editor – photo preview
  $(document).on 'click', '[data-behavior~=editor_photo_preview]', ->
    if $(this).attr('style').length > 2
      N.hideEditorPhotoPreview()
    else
      N.showEditorPhotoPreview()
    return
  # Hide photo preview by clicking overlay
  if $('[data-behavior~=editor_photo_preview]').length > 0
    $(document).on 'click', '[data-behavior~=modal_overlay]', ->
      N.hideEditorPhotoPreview()
      $(this).hide 50

  $('[data-behavior~=autosize]').autosize()
  $('[data-behavior~=editor_instructions]').on 'focus', ->
    this.value = '1. ' if _.isEmpty this.value

  $('[data-behavior~=cook_photo_field]').on 'change', ->
    $(this)[0].form.submit()

  $(document).on 'click', '[data-behavior~=checklist_item]', ->
    $(this).toggleClass 'checked'

  $(document).on 'submit', '[data-behavior~=clip_form]', ->
    v = $('[data-behavior~=clip_url]').val()
    heap.track('Clips Recipe', { 'URL': v })
