var converter = new Showdown.converter();
var inputter = document.getElementById("inputter");

function render() {
  var text = inputter.value;
  var ret = converter.makeHtml(text);
  document.getElementById('rendered').innerHTML = ret;
}
function save() {
    var text = inputter.value;
    // Save text to Evernote
}

function goBack() {
  var history = window.history;
  history.back();
}
