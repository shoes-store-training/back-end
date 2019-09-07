fetch('category3.html')
    .then(data => data.text())
    .then(html => document.getElementById('category').innerHTML = html);


function toggle() { //e để tên khác mà nó không chạy ạ :v
  var dropdown = document.getElementsByClassName("ldropdown-btn");
  var i;
  for (i = 0; i < dropdown.length; i++) {
    dropdown[i].addEventListener("click", function () {
      this.classList.toggle("active");
      var dropdownContent = this.nextElementSibling; //cho thằng dropdownContent = thằng phần tử kế tiếp sau đó coi nó là block hay none để đổi ngược lại
      if (dropdownContent.style.display === "block") {
        dropdownContent.style.display = "none"; // thụt vô clean code
      }
      else {
        dropdownContent.style.display = "block"; // thụt vô clean code
      }
    });
  }
}


