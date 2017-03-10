#= require jquery3
#= require jquery_ujs
#= require turbolinks
#= require lodash
#= require modals
#= require autosize
#= require clipboard
#= require global
#= require components

$(document).on 'turbolinks:load', ->
  N.user = $('body').data('user')
  N.signed_in = _.isNumber N.user
  N.anonymous = !N.signed_in
  N.my_object = (N.signed_in && _.isEqual(N.user, N.object_user)) || false

  N.toggleMenu = (m) ->
    $(m).find('[data-behavior~=menu_content]').slideToggle 120
    o = $(m).attr('aria-expanded') is 'true'
    $(m).attr 'aria-expanded', !o

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

  N.s('flash').delay(5 * 1e3).fadeOut('fast')

  totalModalize()

  $(document).on 'keydown', 'action, [data-behavior~=r_fav]', (e) ->
    $(this).click() if e.keyCode is 32 or e.keyCode is 13

  $('[data-behavior~=inline_signup_form]').on 'ajax:beforeSend', ->
    t = $(this)
    t.html null
    t.toggleClass 'busy busy--large mx-auto'
    t.find('[data-behavior~=hide_on_inline_submit]').hide()
  $(document).on 'ajax:success', '[data-behavior~=inline_signup_form]', ->
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
      r = -> window.location = '/recipes'
    setTimeout r, 600
  $(document).on 'ajax:error', '[data-behavior~=inline_signup_form]', ->
    $(this).toggleClass 'busy busy--large mx-auto bg-darken-1 border rounded pvm mt2 tc'
    $('[data-behavior~=inline_signup_error]').toggleClass 'dn'

  $('[data-behavior~=r_fav_trigger]').on 'change', ->
    $(this)[0].form.submit()
  $(document).on 'click', '[data-behavior~=print]', ->
    window.print()

  # Add preview to embed modal, but only on the first open
  $(document).one 'click', '[data-behavior~=embed_trigger]', ->
    $('#embed').append $('#embed [data-behavior~=copy]').data('clipboard-text')
    $('.section-header').show 0

  if N.theres('recipe_colls_container') and _.includes(window.location.pathname, '/recipes/')
    if _.isEqual N.s('recipe_colls_container').data('user'), N.user
      $.get window.location.pathname + '/collections', (e) ->
        N.s('recipe_colls_container').html e
        N.s('recipe_colls_inactive').hide 0
        $(document).on 'click', '[data-behavior~=recipe_add_colls]', ->
          $('[data-behavior~=recipe_add_colls]').fadeOut 'fast'
          $('[data-behavior~=recipe_colls_inactive]').fadeIn 'fast'
        $(document).on 'change', '[data-behavior~=recipe_colls_check]', ->
          $('[data-behavior~=recipe_colls_submit]').fadeIn 'fast'
        $(document).on 'ajax:error', '[data-behavior~=recipe_colls_form]', (one, two) ->
          N.s('recipe_colls_form').find('input[type=submit]').text '!!!!'
          console.error one, two
        $(document).on 'ajax:success', '[data-behavior~=recipe_colls_form]', ->
          $('[data-behavior~=recipe_colls_submit]').fadeOut 'fast'

  clipboard = new Clipboard '[data-behavior~=copy]', text: (trigger) ->
    trigger.getAttribute 'data-clipboard-text'
  clipboardReset = (t) ->
    t.text 'Copied!'
    setTimeout (-> t.text 'Copy'), 1500
  clipboard.on 'success', (e) ->
    clipboardReset $(e.trigger)
    e.clearSelection()
    return

  # Switch .dn for inline style (prevents flash on load)
  N.s('rehide').hide().removeClass('dn')

  # Show when in various user states – conditionally fill in cached pages
  N.s('show_if_anonymous').removeClass 'dn' if N.anonymous
  N.s('show_if_signed_in').removeClass 'dn' if N.signed_in
  N.s('show_if_my_object').removeClass 'dn' if N.my_object

  if N.theres 'autoselect'
    N.s('autoselect').focus().select()
    $(document).on 'click', '[data-behavior~=autoselect]', (e) ->
      t = e.target
      t.selectionStart = 0
      t.selectionEnd = 999

  $(document).on 'click', '[data-behavior~=photo_button]', ->
    $('[data-behavior~=photo_field]')[0].click()
  $('[data-behavior~=photo_field]').on 'change', ->
    d = N.s('photo_button').find('[data-behavior~=description]')
    d.text this.value.match(/[^\/\\]+$/)[0]
    N.s('recipe_errors').hide 400
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
    p = N.s 'editor_photo_preview'
    d.text 'Removing photo...'
    v = 'blur(1px) grayscale(1)'
    p.css { 'filter': v, '-webkit-filter': v }
    $('[data-behavior~=photo_field]').val null
    $.get $(this).data('href'), (e) ->
      d.text 'Removed!'
      N.s('editor_photo_cont').hide 300, -> p.attr 'style', ''
      t.hide 'slow'
    N.s('recipe_errors').hide 300

  N.s('autosize').autosize()
  $('[data-behavior~=editor_instructions]').on 'focus', ->
    $(this).val '1. ' if _.isEmpty $(this).val()

  $('[data-behavior~=cook_photo_field]').on 'change', ->
    $(this)[0].form.submit()

  $(document).on 'click', '[data-behavior~=checklist_item]', ->
    $(this).toggleClass 'checked'

  $(document).on 'submit', '[data-behavior~=clip_form]', ->
    heap.track 'Clips Recipe', { 'URL': N.s('clip_url').val() }
