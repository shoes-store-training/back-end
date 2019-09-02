function lactive() {
var header = document.getElementById("myDIV");
var btns = header.getElementsByClassName("lbtn");
for (var i = 0; i < btns.length; i++) {
  btns[i].addEventListener("click", function() {
  var current = document.getElementsByClassName("lactives");
  current[0].className = current[0].className.replace(" lactives", "");
  this.className += " lactives";
  });
  }
}