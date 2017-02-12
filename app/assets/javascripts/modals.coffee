(($) ->
  $.fn.extend modalize: (options) ->
    defaults =
      top: 33
      overlay: 0.8
    overlay = $('<div class="modal__overlay" data-behavior="modal_overlay"></div>')
    $('body').append overlay if $('.modal__overlay').length is 0
    options = $.extend(defaults, options)
    @each ->
      o = options
      $(this).click (e) ->
        modal_id = $(this).attr('href')

        close_modal = (modal_id) ->
          $(modal_id).hide()
          $('[data-behavior~=modal_overlay]').hide()

        $(document).on 'click', '[data-behavior~=modal_overlay]', ->
          close_modal modal_id
        $(document).on 'click', '[data-behavior~=modal_close]', ->
          close_modal modal_id
        $(document).keydown (e) ->
          close_modal modal_id if e.keyCode is 27 # esc key

        if $(this).data('behavior').match('modal_close_first')
          $(this).closest('.modal').hide()

        modal_height = $(modal_id).outerHeight()
        modal_width = $(modal_id).outerWidth()
        $('[data-behavior~=modal_overlay]').fadeTo 200, o.overlay

        scrollable = $(modal_id).attr('class').match('modal--scrollable')

        $(modal_id).css
          'display': scrollable ? 'flex' : 'block'
          'position': 'fixed'
          'opacity': 0
          'z-index': 100
          'left': 50 + '%'
          'margin-left': -(modal_width / 2) + 'px'
        $(modal_id).fadeTo 200, 1
        e.preventDefault()
        $(modal_id).children('[data-behavior~=autoselect]').focus().select()
        return
) jQuery

@totalModalize = ->
  $('[data-behavior~=modal_trigger]').modalize()
