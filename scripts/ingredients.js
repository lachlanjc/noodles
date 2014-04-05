// Set the text content of an element
function setText(el, s) {
  if (typeof el.textContent == 'string') {
    el.textContent = s;
  } else if (typeof el.innerText == 'string') {
    el.innerText = s;
  }
}

function update(id, text) {
  var el = document.getElementById("search-field");
  if (el) {
    setText(el, text);
  }
}
