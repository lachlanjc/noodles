#= require autosize

numberRow = ->
  recipeInstructs = document.getElementById("recipe_instructions")
  recipeInstructs.value = "1. " if recipeInstructs.value.length == 0
  return

$(document).ready ->
  document.getElementById("recipe_instructions").addEventListener("focus", numberRow, false)

  $(".details-btn").click ->
    $(".details-panel").toggleClass("hide block")
    $(".details-btn").toggleClass("block hide")

  # Autosize textareas
  $(".js-auto-size").autosize()

  # When you click the nice file button
  $("#file-button").click ->
    # Click the actual file input. Shows dialog.
    $("#file").click()
  # When a file is picked
  $("#file").change ->
    # Find the name of the file
    fileName = document.getElementById("file").value.match(/[^\/\\]+$/)
    # Show the file"s name instead of "Pick something"
    document.getElementById("file-name").innerHTML = fileName
