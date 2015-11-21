#= require trix/dist/trix

$(document).ready ->
  $('[data-behavior~=page_editor_name]').on 'keyup', ->
    n = _.trunc _.trim($(this).val()), 100 || 'Untitled'
    $('[data-behavior~=page_editor_name_bc]').text n
    $('title').text "#{n} – Noodles"

  populateLastSaved = () ->
    v = document.querySelector('trix-editor').editor.getDocument()
    $('[data-behavior~=page_editor_last_saved]').val v

  document.addEventListener 'trix-initialize', (e) ->
    t = $('trix-toolbar')
    t.find('.button_groups').addClass 'phs phxl-ns'
    l = t.find '.link_dialog'
    l.addClass 'bg-white border rounded shadow mx-auto mts mw6'
    l.find('input[type=url]').addClass 'text-input f5 lh'
    fr = _.merge l.find('.button_group'), t.find('.button_group.history_tools')
    fr.addClass 'fr-ns'

    populateLastSaved()
    $(window).bind 'beforeunload', ->
      current = document.querySelector('trix-editor').editor.getDocument().toString()
      saved = $('[data-behavior~=page_editor_last_saved]').val()
      del = $('[data-behavior~=page_delete_btn]').attr('class').match /deleting/
      'You haven\'t saved your work yet!' if (current isnt saved) and !del
    return

  $('[data-behavior~=page_editor]').on 'ajaxBeforeSend', ->
    t = $('[data-behavior~=page_editor_submit]')
    t.attr 'disabled'
    t.attr 'value', 'Saving...'
  $(document).on 'ajaxError', '[data-behavior~=page_editor]', (e, x) ->
    if x.status is 422
      if Object.keys(x.responseJSON).toString() is 'name'
        $('[data-behavior~=page_editor_error_name]').removeClass 'dn'
        $('[data-behavior~=page_editor_error_generic]').addClass 'dn'
    $('[data-behavior~=page_editor_errors]').removeClass 'dn'
    $('[data-behavior~=page_editor_submit]').attr 'value', 'Save again'
  $(document).on 'ajaxSuccess', '[data-behavior~=page_editor]', ->
    t = $('[data-behavior~=page_editor_submit]')
    $('[data-behavior~=page_editor_errors]').addClass 'dn'
    t.attr 'value', 'Saved!'
    populateLastSaved()
    c = -> t.attr 'value', 'Save'
    setTimeout c, 1500

  toggleArchiveStatus = (process) ->
    toggleArchivingClass = -> p.toggleClass "tog--#{process}"
    p = $('[data-behavior~=page]')
    b = $('[data-behavior~=page_archived_banner]')
    toggleArchivingClass()
    id = p.data 'id'
    $.get "/library/pages/#{id}/#{process}", (d) ->
      if process is 'unarchive'
        b.html null
      else
        b.html d
      $('[data-behavior~=page_editor]').submit()
      toggleArchivingClass()
      $('[data-behavior~=page_archive_btn]').toggleClass 'dn'
  togglingStatus = ->
    $('[data-behavior~=page]').attr('class').match /tog/
  $(document).on 'click', '[data-behavior~=page_archive_btn]', ->
    toggleArchiveStatus 'archive'
  $(document).on 'click', '[data-behavior~=page_unarchive_btn]', ->
    toggleArchiveStatus 'unarchive'

  $(document).on 'click', '[data-behavior~=page_delete_btn]', ->
    $(this).addClass 'deleting'

  return
