#= require autosize

numberRow = ->


$(document).ready ->
  $('[data-behavior~=editor_instructions]').on 'focus', ->
    this.value = "1. " if this.value.length == 0
    return

  # Autosize textareas
  $(".js-auto-size").autosize()

  $('[data-behavior~=photo_button]').on 'click', ->
    $('[data-behavior~=photo_field]').click()
    return
  $('[data-behavior~=photo_field]').on 'change', ->
    $('[data-behavior~=photo_name]').text(this.value.match(/[^\/\\]+$/)[0])
    return
  return
