/*--- LOADING HEADER ---*/
fetch('/util/guest-header.html')
    .then(data => data.text())
    .then(html => document.getElementById('header').innerHTML = html);

/*--- RENDER FOR RATING ---*/
function renderRating() {
    var i;
    var j;
    var filterRate = document.getElementById("filter-rating-content");
    for (i = 5; i >= 1; i--) {
        var rateLink = document.createElement('a');
        rateLink.className = "filter-link";
        var rateBox = document.createElement('i');
        rateBox.className = "fas fa-square";
        rateBox.setAttribute("onclick", "checkBox(this);");
        rateLink.appendChild(rateBox);
        var rateSpace = document.createTextNode(" ");
        rateLink.appendChild(rateSpace);
        for (j = 1; j <= i; j++) {
            var rateStarColor = document.createElement('i');
            rateStarColor.className = "fas fa-star";
            rateLink.append(rateStarColor);
        }
        for (j = 5 - i; j >= 1; j--) {
            var rateStarNoColor = document.createElement('i');
            rateStarNoColor.className = "fas fa-star fa-star-no-color";
            rateLink.appendChild(rateStarNoColor);
        }
        var rateNote = document.createTextNode(" and up");
        rateLink.appendChild(rateNote);
        filterRate.appendChild(rateLink);
    }
}
renderRating();

/*--- CHANGE CLICK CHECKBOX ---*/
function checkBox(checkBoxIcon) {
    var checkedIcon = checkBoxIcon.classList.contains("fa-check-square");
    if (checkedIcon) {
        checkBoxIcon.classList.add("fa-square");
        checkBoxIcon.classList.remove("fa-check-square");
    }
    else {
        checkBoxIcon.classList.add("fa-check-square");
        checkBoxIcon.classList.remove("fa-square");
    }
}

/*--- CHANGE PLUS & MINUS ICON IN FILTER ---*/
function expandedFilter(expandedIcon) {
    var clickedIcon = expandedIcon.getElementsByTagName("i")[0];
    var plusIcon = clickedIcon.classList.contains("fa-plus");
    if (plusIcon) {
        clickedIcon.classList.add("fa-minus");
        clickedIcon.classList.remove("fa-plus");
    }
    else {
        clickedIcon.classList.add("fa-plus");
        clickedIcon.classList.remove("fa-minus");
    }
}