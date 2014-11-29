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
  return

@window.onload = ->
  $(".js-auto-size").autosize()
  return
