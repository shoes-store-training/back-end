/*--- LOADING HEADER ---*/
/* global fetch, gender, isSaved */

fetch('./util/user-header.html')
    .then(data => data.text())
    .then(html => document.getElementById('header').innerHTML = html);

/*--- LOADING SIDEBAR ---*/
fetch('./util/profile-sidebar.html')
    .then(data => data.text())
    .then(html => document.getElementById('pr-menu-left').innerHTML = html);

//Button function
const form = document.getElementById(".pr-content");
const changePwBtn = document.getElementById('changepw-btn');
const editBtn = document.getElementById('edit-btn');
const cancelBtn = document.getElementById('cancel-btn');
const saveBtn = document.getElementById('save-btn');
const resetBtn = document.getElementById('reset-btn');
const inputText = document.getElementsByClassName('input-text');
const formControlHidden = document.getElementsByClassName('form-control-hidden');
const helpBlock = document.getElementsByClassName("help-block");
const setAva = document.getElementById("primary");
const formControl = document.getElementsByTagName("input");
function resetForm() {
    for (var i = 0; i < 6; i++) {
        formControl[i].value = ' ';
        formControl[i].style.border = "1px solid #ddd";
    }
    for (var i = 0; i < helpBlock.length; i++) {
        helpBlock[i].innerHTML = " ";
    }
}

saveBtn.onclick = function () {
    if (validateForm() === false) {
        return validateForm();
    }
}

function hideEditForm() {
    changePwBtn.style.display='inline';
    editBtn.style.display='inline';
    cancelBtn.style.display='none';
    saveBtn.style.display='none';
    resetBtn.style.display='none';
    setAva.style.display='none';
    for (var i = 0; i < inputText.length; i++) {
        inputText[i].style.display = 'block';
        formControlHidden[i].style.display = 'none';
    }
    for (var i = 0; i < helpBlock.length; i++) {
        helpBlock[i].innerHTML = " ";
    }
}

function displayEditForm() {
    changePwBtn.style.display='none';
    editBtn.style.display='none';
    cancelBtn.style.display='inline';
    saveBtn.style.display='inline';
    resetBtn.style.display='inline';
    setAva.style.display='block';    
    for (var i = 0; i < inputText.length; i++) {
        inputText[i].style.display = 'none';
        formControlHidden[i].style.display = 'flex';
    }

}


//Validate Form
function validateForm() {
    var name = document.getElementById("full_name").value;
    var phone = document.getElementById("phone_number").value;
    var email = document.getElementById("email").value;

    reason = "";
    reason += validateName(name);
    reason += validatePhone(phone);
    reason += validateEmail(email);
    if (reason.length === 0) {
        return true;
    } else {
        return false;
    }
}

function validateName(name) {
    var error = "";
    if (name.length == 0) {
        invalidAlert("full_name");
        document.getElementById("name-error").innerHTML = "Full name has not been filled in!";       
        error = "1";
        return error;
    }
    if (name.length != 0) {
        validAlert("full_name");
        document.getElementById("name-error").innerHTML = "";
        return "";
    }
}

function validatePhone(phone) {
    var error = "";
    if (phone.length == 0) {
        invalidAlert("phone_number");
        document.getElementById("phone-error").innerHTML = "Phone number has not been filled in!";       
        error = "1";
        return error;
    } else if (phone.length != 10 || isNaN(phone)) {
        invalidAlert("phone_number");
        document.getElementById("phone-error").innerHTML = "Please input a valid phone number!";
        error = "1";
        return error;
    } else {
        validAlert("phone_number");
        document.getElementById("phone-error").innerHTML = "";
        return "";
    }
}

function validateEmail(email) {
    var error = "";
    var isValidMail = /[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?/igm; 
    if (email.length == 0) {
        invalidAlert("email");
        document.getElementById("email-error").innerHTML = "Email has not been filled in!";       
        error = "1";
        return error;
    } else if (!isValidMail.test(String(email).toLowerCase())) {
        invalidAlert("email");
        document.getElementById("email-error").innerHTML = "Please input a valid email!";       
        error = "1";
        return error;
    } else {
        validAlert("email");
        document.getElementById("email-error").innerHTML = "";
        return "";
    }
}

//show red border when input invalid
function invalidAlert(idName) {
    document.getElementById(idName).style.border = "1px solid red";
}

//show green border when input invalid
function validAlert(idName) {
    document.getElementById(idName).style.border = "1px solid green";
}

//Upload avatar
var loadFile = function(event) {
    var reader = new FileReader();
    reader.onload = function(){
        var output = document.getElementById('thumbBox');
        output.src = reader.result;
    };
    reader.readAsDataURL(event.target.files[0]);
};

//Extra code to work on view profile back end
male = document.getElementById("gender_male");
female = document.getElementById("gender_female");
if (gender === "Female") {
    female.checked = true;
} else {
    male.checked = true;
}
if (isSaved === "true"){
    window.alert("Successfully");
}