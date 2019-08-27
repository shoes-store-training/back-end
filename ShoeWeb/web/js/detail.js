/* LOAD HEADER */
fetch('/util/guest-header.html')
    .then(data => data.text())
    .then(html => document.getElementById('header').innerHTML = html);

/* LOAD REVIEW */
fetch('/util/review.html')
    .then(data => data.text())
    .then(html => document.getElementById('review').innerHTML = html);

/* CHOOSE SHOES COLOR */
function chooseShoesColor(pos) {
    var imgList = document.getElementsByClassName("image-list");
    var buttonImageList = document.getElementsByClassName("detail-content-image");
    var detailModal = document.getElementsByClassName("detail-modal-image");
    var reviewModal = document.getElementsByClassName("review-modal-image");
    for (var i = 0; i < imgList.length; i++) {
        imgList[i].style.display = "none";
        detailModal[i].style.display = "none";
        reviewModal[i].style.display = "none";
        buttonImageList[i].style.filter = "brightness(90%)";
    }
    imgList[pos - 1].style.display = "inline-block";
    buttonImageList[pos - 1].style.filter = "brightness(60%)";
    detailModal[pos - 1].style.display = "inline-block";
    reviewModal[pos - 1].style.display = "inline-block";
}

/* CHOOSE SHOES SIZE */
function chooseShoesSize(selectedButtonSize) {
    var normalBtnColor = "#323232"; /* dark gray */
    var normalBtnBgColor = "#FBFBFB"; /* dark white */
    var selectBtnColor = "#FBFBFB";
    var selectBtnBgColor = "#000000"; /* black */
    var i;
    var buttonSizeList = document.getElementsByClassName("detail-content-size-button");
    for (i = 0; i < buttonSizeList.length; i++) {
        buttonSizeList[i].style.color = normalBtnColor;
        buttonSizeList[i].style.backgroundColor = normalBtnBgColor;
    }
    selectedButtonSize.style.color = selectBtnColor;
    selectedButtonSize.style.backgroundColor = selectBtnBgColor;
}

/* CHECK VALID SIZE */
function checkProduct() {
    var errorMessageList = document.getElementsByClassName("error-message");
    for (var i = 0; i < errorMessageList.length; i++) {
        errorMessageList[i].parentNode.removeChild(errorMessageList[i]);
    }
    var flagSize = true;
    var flagColor = true;
    var shoeSize = document.forms["select-shose"]["select-size"].value;
    var shoeColor = document.forms["select-shose"]["select-color"].value;
    if (shoeColor == "") {
        var errorMessage = document.createElement("div");
        errorMessage.className = "col-sm-12 text-danger bg-danger error-message";
        var colorPart = document.getElementById("detail-color");
        var errorContent = document.createTextNode("Please choose a color");
        errorMessage.appendChild(errorContent);
        colorPart.appendChild(errorMessage);
        flagColor = false;
    }
    if (shoeSize == "") {
        var errorMessage = document.createElement("div");
        errorMessage.className = "col-sm-12 text-danger bg-danger error-message";
        var sizePart = document.getElementById("detail-size");
        var errorContent = document.createTextNode("Please choose a size");
        errorMessage.appendChild(errorContent);
        sizePart.appendChild(errorMessage);
        flagSize = false;
    }
    return (flagSize && flagColor);
}

/* TOOLTIP COLOR IMAGE */
function tooltipImage(imgColor) {
    $(imgColor).tooltip();
}