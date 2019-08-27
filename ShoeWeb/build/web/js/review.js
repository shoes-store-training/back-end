function ratingStar(starNumber) {
    var starRatingList = document.getElementsByClassName("star-rating");
    for (var i = 0; i < 5; i++) {
        starRatingList[i].classList.remove("star-rating-checked");
    }
    for (var i = 0; i < starNumber; i++) {
        starRatingList[i].classList.add("star-rating-checked");
    }
}