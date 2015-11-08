#= require trix/dist/trix

$(document).ready ->
  $('[data-behavior~=page_editor_name]').on 'keyup', ->
    n = _.trunc _.trim($(this).val()), 100
    $('[data-behavior~=page_editor_name_bc]').text n || 'Untitled'

  document.addEventListener 'trix-initialize', (e) ->
    t = $('trix-toolbar')
    t.find('.button_groups').addClass 'phs phxl-ns'
    l = t.find '.link_dialog'
    l.addClass 'bg-white border rounded shadow mx-auto mts mw6'
    l.find('input[type=url]').addClass 'text-input f5 lh'
    b = l.find '.button_group'
    b.addClass 'relative fr'
    b.css { 'top': '.25rem' }

    $(window).bind 'beforeunload', ->
      cv = document.querySelector('trix-editor').editor.getDocument().toString()
      lsv = $('[data-behavior~=page_editor_last_saved]').val()
      del = $('[data-behavior~=page_delete_btn]').attr('class').match(/deleting/)
      if (cv isnt lsv) and !del
        'You have NOT saved your work yet!'

  $('[data-behavior~=page_editor]').on 'ajaxBeforeSend', ->
    t = $('[data-behavior~=page_editor_submit]')
    t.attr 'disabled'
    t.attr 'value', 'Saving...'
  $(document).on 'ajaxError', '[data-behavior~=page_editor]', (event, xhr) ->
    t = $('[data-behavior~=page_editor_errors]')
    if xhr.status is 422
      if Object.keys(xhr.responseJSON).toString() is 'name'
        $('[data-behavior~=page_editor_error_name]').removeClass 'dn'
        $('[data-behavior~=page_editor_error_generic]').addClass 'dn'
    t.removeClass 'dn'
    $('[data-behavior~=page_editor_submit]').attr 'value', 'Save again'
  $(document).on 'ajaxSuccess', '[data-behavior~=page_editor]', ->
    t = $('[data-behavior~=page_editor_submit]')
    $('[data-behavior~=page_editor_errors]').addClass 'dn'
    t.attr 'value', 'Saved!'
    v = document.querySelector('trix-editor').editor.getDocument()
    $('[data-behavior~=page_editor_last_saved]').val v
    c = -> t.attr 'value', 'Save'
    setTimeout c, 1500

  $(document).on 'click', '[data-behavior~=page_delete_btn]', ->
    $(this).addClass 'deleting'

  return
