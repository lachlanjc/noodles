function showDetails() {
  document.getElementById('details-container').setAttribute('class', 'show');
  document.getElementById('details-btn').setAttribute('class', 'hide');
}

function numberRow() {
  value = document.getElementById('instructions-input').value;
  if (value.length === 0) {
    value = '1. ';
  }
}
