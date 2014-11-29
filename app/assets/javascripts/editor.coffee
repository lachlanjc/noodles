#= require autosize

@showEditorDetails = ->
  document.getElementById('editor-details-container').setAttribute 'class', 'show panel'
  document.getElementById('editor-details-btn').setAttribute 'class', 'hide'
  return

@numberRow = ->
  @value = document.getElementById('instructions-input').value
  @value = '1. '  if @value.length is 0
  return

@window.onload = ->
  document.getElementById('instructions-input').addEventListener 'focus', @numberRow, false
  document.getElementById('editor-details-btn').addEventListener 'click', @showEditorDetails, false

  $ ->
    $('.js-auto-size').autosize()
    $('#file-button').click ->
      $('#file').click()
      return
    $('#file').change ->
      path = document.getElementById('file').value
      fileName = path.match(/[^\/\\]+$/)
      document.getElementById('file-name').innerHTML = fileName
      return
    return
