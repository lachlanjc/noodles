// Set the text content of an element
// Some browsers support only textContent, some only innerText, some both
// so cater for them all
function setText(el, s) {
  if (typeof el.textContent == 'string') {
    el.textContent = s;
  } else if (typeof el.innerText == 'string') {
    el.innerText = s;
  }
}

// Given an element ID, set the text to text
function update(id, text) {
  var el = document.getElementById(id);
  if (el) {
    setText(el, text);
  }
}