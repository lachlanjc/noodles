#= require trix/dist/trix

$(document).ready ->
  $('[data-behavior~=page_editor_name]').on 'keyup', ->
    n = _.trunc _.trim($(this).val()), 100 || 'Untitled'
    $('[data-behavior~=page_editor_name_bc]').text n
    $('title').text "#{n} – Noodles"

  populateLastSaved = () ->
    v = document.querySelector('trix-editor').editor.getDocument()
    $('[data-behavior~=page_editor_last_saved]').val v
    v

  document.addEventListener 'trix-initialize', (e) ->
    t = $('trix-toolbar')
    t.find('.button_groups').addClass 'phs phxl-ns'
    t.find('.button_group.history_tools').addClass 'fr-ns'
    l = t.find '.link_dialog'
    l.addClass 'bg-white border rounded shadow mx-auto mts mw6'
    l.find('input[type=url]').addClass 'text-input f5 lh'
    b = l.find '.button_group'
    b.addClass 'fr'

    populateLastSaved()
    $(window).bind 'beforeunload', ->
      current = document.querySelector('trix-editor').editor.getDocument().toString()
      saved = $('[data-behavior~=page_editor_last_saved]').val()
      del = $('[data-behavior~=page_delete_btn]').attr('class').match /deleting/
      if (current isnt saved) and !del
        'You have NOT saved your work yet!'
    return

  $('[data-behavior~=page_editor]').on 'ajaxBeforeSend', ->
    t = $('[data-behavior~=page_editor_submit]')
    t.attr 'disabled'
    t.attr 'value', 'Saving...'
  $(document).on 'ajaxError', '[data-behavior~=page_editor]', (e, x) ->
    t = $('[data-behavior~=page_editor_errors]')
    if x.status is 422
      if Object.keys(x.responseJSON).toString() is 'name'
        $('[data-behavior~=page_editor_error_name]').removeClass 'dn'
        $('[data-behavior~=page_editor_error_generic]').addClass 'dn'
    t.removeClass 'dn'
    $('[data-behavior~=page_editor_submit]').attr 'value', 'Save again'
  $(document).on 'ajaxSuccess', '[data-behavior~=page_editor]', ->
    t = $('[data-behavior~=page_editor_submit]')
    $('[data-behavior~=page_editor_errors]').addClass 'dn'
    t.attr 'value', 'Saved!'
    populateLastSaved()
    c = -> t.attr 'value', 'Save'
    setTimeout c, 1500

  $(document).on 'click', '[data-behavior~=page_delete_btn]', ->
    $(this).addClass 'deleting'

  return
