//Set date input field's max date to today
function maxToday() {
    var today = new Date();
    var dd = today.getDate();
    var mm = today.getMonth()+1; //January is 0!
    var yyyy = today.getFullYear();
        if (dd < 10) {
            dd = '0' + dd;
        } 
        if (mm < 10) {
            mm = '0' + mm;
        } 
    return today = yyyy+'-'+mm+'-'+dd;
}
document.getElementById("birthday-picker").setAttribute("max", maxToday());    

const form = document.getElementById("pr-content");
const saveBtn = document.getElementById('m-subheader__submit');
const resetBtn = document.getElementById('m-subheader__reset');
const helpBlock = document.getElementsByClassName("help-block");
const formControl = document.getElementsByTagName("input");
function resetForm() {
    for (var i = 1; i < 6; i++) {
        formControl[i].value =' ';
        formControl[i].style.border = "1px solid #ddd";
    }
    for (var i = 0; i < helpBlock.length; i++) {
        helpBlock[i].innerHTML = " ";
    }
}
saveBtn.onclick = function() {
    return validateForm();
}


//Validate Form
function validateForm() {
    var fname = document.getElementById("first_name").value; 
    var lname = document.getElementById("last_name").value;
    var phone = document.getElementById("phone_number").value;
    var email = document.getElementById("email").value;

    reason = "";
    reason += validateName(fname, lname);
    reason += validatePhone(phone);
    reason += validateEmail(email);

    if (reason.length > 0) {
        return false;
    } else {
        return false;
    }
}

function validateName(fname, lname) {
    var error = "";
    if (fname.length == 0 && lname.length == 0) {
        invalidAlert("first_name");
        invalidAlert("last_name");
        document.getElementById("name-error").innerHTML = "Both First name and Last name have not been filled in!";       
        error = "1";
        return error;
    }
    else if (fname.length != 0 && lname.length == 0) {
        validAlert("first_name");
        invalidAlert("last_name");
        document.getElementById("name-error").innerHTML = "Last name has not been filled in!";       
        error = "1";
        return error;
    }
    else if (fname.length == 0 && lname.length != 0) {
        invalidAlert("first_name");
        validAlert("last_name");
        document.getElementById("name-error").innerHTML = "First name has not been filled in!";       
        error = "1";
        return error;
    }
    if (fname.length != 0 && lname.length != 0) {
        validAlert("first_name");
        validAlert("last_name");
        document.getElementById("name-error").innerHTML = "";       
    }
}


function validatePhone(phone) {
    var error = "";
    if (phone.length == 0) {
        invalidAlert("phone_number");
        document.getElementById("phone-error").innerHTML = "Phone number has not been filled in!";       
        error = "1";
        return error;
    }
    else if (phone.length != 10 || isNaN(phone)) {
        invalidAlert("phone_number");
        document.getElementById("phone-error").innerHTML =  "Please input a valid phone number!";       
        error = "1";
        return error;
    }
    else {
        validAlert("phone_number");
        document.getElementById("phone-error").innerHTML = "";       
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
    }
    else if (!isValidMail.test(String(email).toLowerCase())) {
        invalidAlert("email");
        document.getElementById("email-error").innerHTML = "Please input a valid email!";       
        error = "1";
        return error;
    }
    else {
        validAlert("email");
        document.getElementById("email-error").innerHTML = "";       
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
const loadFile = function(event) {
    var reader = new FileReader();
    reader.onload = function(){
        var output = document.getElementById('thumbBox');
        output.src = reader.result;
    };
    reader.readAsDataURL(event.target.files[0]);
};