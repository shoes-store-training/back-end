//Check if input on login form is valid

document.getElementById("loginButton").onclick = function () { return isLoginAccountValid() };

function isLoginAccountValid() {
  var snackbar = document.getElementById("snackbar");
  snackbar.className = "show";
  var username = document.getElementById("username").value.toLowerCase();
  var password = document.getElementById("password").value;
  if (password === "" || username === "") {
    snackbar.textContent = 'Wrong username or password';
    setTimeout(function () { snackbar.className = snackbar.className.replace("show", ""); }, 3000); //Snackbar fadein and being visible in 3s
    return false;
  }
  return true;
}