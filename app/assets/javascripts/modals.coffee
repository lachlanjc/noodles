(($) ->
  $.fn.extend modalize: (options) ->
    defaults =
      top: 33
      overlay: 0.8
    overlay = $('<div class="col-12 bg-darken-4 modal__overlay" data-behavior="modal_overlay"></div>')
    $('body').append overlay if $('.modal__overlay').length is 0
    options = $.extend(defaults, options)
    @each ->
      o = options
      $(this).click (e) ->
        modal_id = $(this).attr('href')

        close_modal = (modal_id) ->
          $(modal_id).hide()
          $('[data-behavior~=modal_overlay]').hide()

        $('[data-behavior~=modal_overlay]').click ->
          close_modal modal_id
        $('[data-behavior~=modal_close]').click ->
          close_modal modal_id
        $(document).keydown (e) ->
          close_modal modal_id if e.keyCode is 27
        modal_height = $(modal_id).outerHeight()
        modal_width = $(modal_id).outerWidth()
        $('[data-behavior~=modal_overlay]').fadeTo 200, o.overlay
        $(modal_id).css
          'display': 'block'
          'position': 'fixed'
          'opacity': 0
          'z-index': 100
          'left': 50 + '%'
          'margin-left': -(modal_width / 2) + 'px'
        $(modal_id).fadeTo 200, 1
        e.preventDefault()
        return
) jQuery

@totalModalize = ->
  $('[data-behavior~=modal_trigger]').modalize()
