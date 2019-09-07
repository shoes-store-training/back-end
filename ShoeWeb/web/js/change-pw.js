/*--- LOADING HEADER ---*/
/* global oldPassWord */

fetch('./util/user-header.html')
    .then(data => data.text())
    .then(html => document.getElementById('header').innerHTML = html);

/*--- LOADING SIDEBAR ---*/
fetch('./util/profile-sidebar.html')
    .then(data => data.text())
    .then(html => document.getElementById('pr-menu-left').innerHTML = html);


//Button function
const form = document.getElementById(".pr-content");
const cancelBtn = document.getElementById('cancel-btn');
const saveBtn = document.getElementById('save-btn');
const resetBtn = document.getElementById('reset-btn');
const formControlHidden = document.getElementsByClassName('form-control-hidden');
const helpBlock = document.getElementsByClassName("help-block");
const formControl = document.getElementsByTagName("input");
function resetForm() {
    for (var i = 0; i < formControl.length; i++) {
        formControl[i].value ='';
        formControl[i].style.border = "1px solid #ddd";
    }
    for (var i = 0; i < helpBlock.length; i++) {
        helpBlock[i].innerHTML = "";
    }
}

saveBtn.onclick = function() {
    if (validateForm() === false) {
        return validateForm();
    }
    else alert("Change password successfully!");
}

function backToViewPage() {
    window.location='view-edit-profile-user.jsp';
}

//Validate Form
function validateForm() {
    var currentpw = document.getElementById("current_pw").value;
    var newpw = document.getElementById("new_pw").value;
    var retypepw = document.getElementById("retype_pw").value;

    reason = " ";
    reason += validateCurrentPw(currentpw);
    reason += validateNewPw(newpw);
    reason += validateRetypePw(retypepw, newpw);
    if (reason.length > 1) {
        return false;
    } else {
        return true;
    }
}

function validateCurrentPw(currentpw) {
    var error = "";
    if (currentpw.length == 0) {
        invalidAlert("current_pw");
        document.getElementById("currentPw-error").innerHTML = "This field has not been filled in!";       
        error = "1";
        return error;
    }
    else if(oldPassWord !== currentpw){
        invalidAlert("current_pw");
        document.getElementById("currentPw-error").innerHTML = "Wrong password";       
        error = "1";
        return error;
    }
    else {
        validAlert("current_pw");
        document.getElementById("currentPw-error").innerHTML = " ";   
        return error;
    }
}
function validateNewPw(newpw) {
    var error = "";
    if (newpw.length == 0) {
        invalidAlert("new_pw");
        document.getElementById("newPw-error").innerHTML = "This field has not been filled in!";       
        error = "1";
        return error;
    }
    else if (newpw.length < 6) {
        invalidAlert("new_pw");
        document.getElementById("newPw-error").innerHTML = "Password must be at least 6 characters!";       
        error = "1";
        return error;
    }
    else {
        validAlert("new_pw");
        document.getElementById("newPw-error").innerHTML = " ";   
        return error;
    }
}
function validateRetypePw(retypepw, newpw) {
    var error = "";
    if (retypepw.length == 0) {
        invalidAlert("retype_pw");
        document.getElementById("retypePw-error").innerHTML = "This field has not been filled in!";       
        error = "1";
        return error;
    }
    else if (retypepw != newpw) {
        invalidAlert("retype_pw");
        document.getElementById("retypePw-error").innerHTML = "Password don't match!";       
        error = "1";
        return error;
    }
    else {
        validAlert("retype_pw");
        document.getElementById("retypePw-error").innerHTML = " ";   
        return error;
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

