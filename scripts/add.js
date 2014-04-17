function addIngredient() {
  var list = document.getElementById("ingredients")
  list.innerHTML += '<input type="text" placeholder="Ingredient">'
}
var hidden-input = document.getElementById('hidden-input');
hidden-input.onfocus = hidden-input.blur;
mike.onwebkitspeechchange = function(e) {
    //console.log(e); // SpeechInputEvent
    document.getElementById('instructions').value = hidden-input.value;  
};