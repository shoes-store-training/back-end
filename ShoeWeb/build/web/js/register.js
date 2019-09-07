const INVALID_COLOR = "#df51514b"; //this color is red
const ORIGINAL_COLOR = "#fafafa"; //this color is white

//Check if input_information on register form is valid
document.getElementById("signupButton").onclick = function () { return isRegisterInfoValid() };

function isRegisterInfoValid() {
  var snackbar = document.getElementById("snackbar");
  snackbar.className = "show";
  var username = document.getElementById("username").value.toLowerCase();
  var password = document.getElementById("password").value;
  var mail = document.getElementById("mail").value;
  var customerName = document.getElementById("first_name").value + document.getElementById("last_name").value;
  var isValidMail = /[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?/igm; 
  //return true if mail have form: "['A'-'Z' or <some visible characer> ] + @ + Any single character + '.' + Any single character"
  var whileSpacePos = username.lastIndexOf(' ');   // return position of the first a space found else -1

  if (!isValidMail.test(mail) || mail.length > 64) {
    snackbar.textContent = 'Invalid mail!';
    showSnackbar(snackbar);
    invalidAlert("mail");
    return false;
  } else {
    retuenValidFieldColor("mail");
  }

  if (username.length < 7 || username.length > 41) {
    snackbar.textContent = 'Username must be between 6 and 40 characters long!';
    showSnackbar(snackbar);
    invalidAlert('username');
    return false;
  }

  if (whileSpacePos !== -1) {
    snackbar.textContent = 'Usename can\'t contain a space!';
    showSnackbar(snackbar);
    invalidAlert('username');
    return false;
  } else {
    retuenValidFieldColor('username');
  }

  if (password.length < 6) {
    snackbar.textContent = 'Password must be at least 6 characters long!';
    showSnackbar(snackbar);
    invalidAlert('password');
    return false;
  } else {
    retuenValidFieldColor('password');
  }

  if (customerName === "") {
    snackbar.textContent = 'First name or last name has not inputed!';
    showSnackbar(snackbar);
    invalidAlert('first_name');
    invalidAlert('last_name');
    return false;
  } else {
    retuenValidFieldColor('first_name');
    retuenValidFieldColor('last_name');
  }

  return true;
}

function showSnackbar(snackbar) {
  setTimeout(function () { snackbar.className = snackbar.className.replace("show", ""); }, 3000); //Snackbar fadein and being visible in 3s
}

function invalidAlert(idName) {
  document.getElementById(idName).style.background = INVALID_COLOR; //turn input field into red
}

function retuenValidFieldColor(idName) {
  document.getElementById(idName).style.background = ORIGINAL_COLOR;  //turn input field into white
}