#= require trix/dist/trix

$(document).ready ->
  $('[data-behavior~=page_editor_name]').on 'keyup', ->
    name = _.trunc _.trim($(this).val()), 100
    if name.length > 0
      n = name
    else
      n = 'Untitled'
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

  $(document).on 'click', '[data-behavior~=page_editor_submit]', ->
    t = $(this)
    t.attr 'disabled'
    t.attr 'value', 'Saving...'
  $(document).on 'ajaxError', '[data-behavior~=page_editor]', (e, x) ->
    if x.status is 422
      s = $('[data-behavior~=page_error_spec]')
      f = _.keys(x.responseJSON)[0]
      m = _.values(x.responseJSON).toString()
      s.find('[data-behavior~=page_error_spec_field]').text f
      s.find('[data-behavior~=page_error_spec_message]').text m
      $('[data-behavior~=page_error_generic]').hide 'fast'
      s.show 'fast'
    $('[data-behavior~=page_errors]').show 'fast'
    $('[data-behavior~=page_editor_submit]').attr 'value', 'Save again'
  $(document).on 'ajaxSuccess', '[data-behavior~=page_editor]', ->
    t = $('[data-behavior~=page_editor_submit]')
    $('[data-behavior~=page_errors]').hide 'fast'
    populateLastSaved()
    if t.attr('value') is 'Saving...'
      t.attr 'value', 'Saved!'
      c = -> t.attr 'value', 'Save'
      setTimeout c, 1500

  toggleArchiveStatus = (process) ->
    p = $('[data-behavior~=page]')
    b = $('[data-behavior~=page_archived_banner]')
    id = p.data 'id'
    $.get "/library/pages/#{id}/#{process}", (d) ->
      if process is 'unarchive'
        b.html null
      else
        b.html d
      $('[data-behavior~=page_editor]').submit()
      $('[data-behavior~=page_archive_btn], [data-behavior~=page_archive_bc], [data-behavior~=page_sidebar], [data-behavior~=page_color_banner]').toggle 'fast'
  $(document).on 'click', '[data-behavior~=page_archive_btn]', ->
    toggleArchiveStatus 'archive'
  $(document).on 'click', '[data-behavior~=page_unarchive_btn]', ->
    toggleArchiveStatus 'unarchive'

  $(document).on 'click', '[data-behavior~=swatch]', ->
    p = $('[data-behavior~=swatch][selected]').data 'color'
    n = $(this).data 'color'
    $('[data-behavior~=swatch]').removeAttr 'selected'
    $(this).attr 'selected', true
    $('[data-behavior~=page_color_banner]').toggleClass "swatch--#{p} swatch--#{n}"
    $('[data-behavior~=page_color_val]').val n
    if _.trim($('[data-behavior~=page_editor_name]').val()).length > 0
      $('[data-behavior~=page_editor]').submit()

  $(document).on 'click', '[data-behavior~=page_delete_btn]', ->
    $(this).addClass 'deleting'

  return
