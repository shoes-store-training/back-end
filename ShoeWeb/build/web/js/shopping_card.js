var tabButton = document.getElementsByClassName("tab-button");
var tabContent = document.getElementsByClassName("tab-content");
var nextButton = document.getElementsByClassName("continue");
var preButton = document.getElementsByClassName("previous");

// var i;
// for (i = 0; i < tabButton.length; i++){
//   tabButton[0].addEventListener("click", function () {
//     openTab(0);
//   });
// };
$(".qt").each(function () {
    var el = $(this);
    changeVal(el);;
});
changeTotal();

tabButton[0].addEventListener("click", function () {
  openTab(0);
});

tabButton[1].addEventListener("click", function () {
  openTab(1);
});

tabButton[2].addEventListener("click", function () {
  openTab(2);
});

nextButton[0].addEventListener("click", function () {
  openTab(1);
});

nextButton[1].addEventListener("click", function () {
  openTab(2);
});

preButton[0].addEventListener("click", function () {

});

preButton[1].addEventListener("click", function () {
  openTab(0);
});

preButton[2].addEventListener("click", function () {
  openTab(1);
});

function openTab(currenttab) {
  for (var i = currenttab; i < tabButton.length; i++) {
    tabButton[i].className = tabButton[i].className.replace(" tab-button-active", "");
    tabContent[i].className = tabContent[i].className.replace(" tab-content-active", "");
  };
  for (var i = 0; i < tabButton.length; i++) {
    tabContent[i].className = tabContent[i].className.replace(" tab-content-active", "");
  };
  tabButton[currenttab].className += " tab-button-active";
  tabContent[currenttab].className += " tab-content-active";
}

// ==============================================================
var check = false;

function changeVal(el) {
  var qt = parseFloat(el.parent().children(".qt").html().replace('$', ''));
  var price = parseFloat(el.parent().children(".price").html().replace('$', ''));
  var eq = Math.round(price * qt * 100) / 100;
  // console.log(qt);
  // console.log(price);
  // console.log(eq);
  el.parent().parent().parent().next().children(".full-price").html("$" + eq);

  changeTotal();
}

function changeTotal() {

  var sum = 0;
  var differnce = 0;
  var qt = 0;
  var discount = 0;
  console.log("============== ");
  $(".full-price").each(function () {
    var el = $(this).parent().text().replace('$', '');
    sum += parseFloat(el);
  });

  $(".qt").each(function () {
    qt += parseFloat($(this).text());
  });
  console.log("quantity: " + qt);

  
  discount = (sum * 0.2);

  if (sum === 0) {
    differnce = 0;
  }

  discount = +discount.toFixed(2);
  sum = +sum.toFixed(2);
  differnce = (sum - discount).toFixed(2);
  var total = 0;
  var shipping = 0;
  // $("shipping-copute").html();
  // console.log("Shipping: " + shipping);
  total = (differnce + shipping);
  // total = total.toFixed(2);
  $(".subtotal-compute").html("$" + sum);
  $(".discount-compute").html("- $" + discount);
  $(".difference-compute").html("$" + differnce);
  $(".product-counter").html(qt);
  $(".total-compute").html("$" +total);
}

$(document).ready(function () {
  $(".remove").click(function () {
    var el = $(this);
    el.parent().parent().addClass("removed");
    window.setTimeout(
      function () {
        el.parent().parent().parent().parent().parent().slideUp('fast', function () {
          el.parent().parent().parent().parent().remove();
          changeTotal();
        });
      }, 80);
  });

  $(".qt-plus").click(function () {
    $(this).parent().children(".qt").html(parseInt($(this).parent().children(".qt").html()) + 1);
    $(this).parent().parent().parent().next().children(".full-price").addClass("added");
    var el = $(this);
    window.setTimeout(function () { el.parent().parent().parent().next().children(".full-price").removeClass("added"); changeVal(el); }, 200);
  });

  $(".qt-minus").click(function () {

    child = $(this).parent().children(".qt");

    if (parseInt(child.html()) > 1) {
      child.html(parseInt(child.html()) - 1);
    }

    $(this).parent().parent().parent().next().children(".full-price").addClass("minused");

    var el = $(this);
    window.setTimeout(function () { el.parent().parent().parent().next().children(".full-price").removeClass("minused"); changeVal(el); }, 200);
  });

  $(".btn").click(function () {
    check = true;
    $(".remove").click();
  });
});