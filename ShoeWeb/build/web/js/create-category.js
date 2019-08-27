window.onload = function () {
    
    var modal = document.getElementById("container-crecago");
    var openFormBtn = document.getElementById("button-crecago");
    var closeFormBtn = document.getElementsByClassName("close")[0];

    openFormBtn.onclick = function openForm() {
        modal.style.display = "block";
    }
    closeFormBtn.onclick = function closeForm() {
        modal.style.display = "none";
    }
    window.onclick = function (event) {
        if (event.target == modal) {
            modal.style.display = "none";
        }
    }

    var buttonAddSize = document.getElementById('button-More-Size');
    buttonAddSize.onclick = function addSizeOption() {
        text = document.getElementById('more-Size');
        if (text.value !== "" && !isNaN(text.value)) {
            var a = document.getElementById('size-Select');
            var b = document.createElement('div');
            b.setAttribute("class", "checkbox-crecago")
            var checkbox = document.createElement('input');
            checkbox.type = "checkbox";
            checkbox.value = text.value;
            checkbox.name = "size" + text.value;
            checkbox.id = "size" + text.value;
            var label = document.createElement('label');
            label.setAttribute("for", "size" + text);
            b.appendChild(checkbox);
            b.appendChild(label);
            var c = document.createElement('div');
            c.setAttribute("class", "container-choice-crecago");
            c.appendChild(b);
            var d = document.createElement('div');
            d.setAttribute("class", "name-choice-crecago");
            d.appendChild(document.createTextNode(text.value));
            c.appendChild(d);
            var e = document.getElementById('add-Size-Option');
            a.insertBefore(c, e);
            document.getElementById('more-Size').value ="";
        }
    }

    var buttonAddBrand = document.getElementById('button-More-Brand');
    buttonAddBrand.onclick = function addBrandOption() {
        text = document.getElementById('more-Brand');
        if (text.value !== "") {
            var a = document.getElementById('brand-Select');
            var b = document.createElement('div');
            b.setAttribute("class", "checkbox-crecago");
            var checkbox = document.createElement('input');
            checkbox.type = "checkbox";
            checkbox.name = text.value;
            checkbox.id = text.value;
            var label = document.createElement('label');
            label.setAttribute("for", text.value);
            b.appendChild(checkbox);
            b.appendChild(label);
            var c = document.createElement('div');
            c.setAttribute("class", "container-choice-crecago");
            c.appendChild(b);
            var d = document.createElement('div');
            d.setAttribute("class", "name-choice-crecago");
            d.appendChild(document.createTextNode(text.value));
            c.appendChild(d);
            var e = document.getElementById('add-Brand-Option');
            a.insertBefore(c, e);
            document.getElementById('more-Brand').value = "";
        }
    }

    var buttonAddColor = document.getElementById('button-More-Color');
    buttonAddColor.onclick = function addColorOption() {
        text = document.getElementById('more-Color');
        if (text.value !== "") {
            var a = document.getElementById('color-Select');
            var b = document.createElement('div');
            b.setAttribute("class", "checkbox-crecago");
            var checkbox = document.createElement('input');
            checkbox.type = "checkbox";
            checkbox.name = text.value;
            checkbox.id = text.value;
            var label = document.createElement('label');
            label.setAttribute("for", text.value);
            b.appendChild(checkbox);
            b.appendChild(label);
            var c = document.createElement('div');
            c.setAttribute("class", "container-choice-crecago");
            c.appendChild(b);
            var d = document.createElement('div');
            d.setAttribute("class", "name-choice-crecago");
            d.appendChild(document.createTextNode(text.value));
            c.appendChild(d);
            var e = document.getElementById('add-Color-Option');
            a.insertBefore(c, e);
            document.getElementById('more-Color').value = "";
        }
    }

    var buttonAddPrice = document.getElementById('button-More-Price');
    buttonAddPrice.onclick = function addPriceOption() {
        text = document.getElementById('more-Price');
        if (text.value !== "") {
            var a = document.getElementById('price-Select');
            var b = document.createElement('div');
            b.setAttribute("class", "checkbox-crecago");
            var checkbox = document.createElement('input');
            checkbox.type = "checkbox";
            checkbox.name = text.value;
            checkbox.id = text.value;
            var label = document.createElement('label');
            label.setAttribute("for", text.value);
            b.appendChild(checkbox);
            b.appendChild(label);
            var c = document.createElement('div');
            c.setAttribute("class", "container-choice-crecago");
            c.appendChild(b);
            var d = document.createElement('div');
            d.setAttribute("class", "name-choice-crecago");
            d.appendChild(document.createTextNode(text.value));
            c.appendChild(d);
            var e = document.getElementById('add-Price-Option');
            a.insertBefore(c, e);
            document.getElementById('more-Price').value = "";
        }
    }


    buttonRefresh = document.getElementById('refreshbutton');
    buttonRefresh.onclick = function refreshForm(){
        modal.location.reload(true);
    }

};
