//Import header 
fetch('./util/admin-header.html')
    .then(data => data.text())
    .then(html => document.getElementById('header').innerHTML = html);
    
//Import sidebar 
fetch('./util/admin-sidebar.html')
    .then(data => data.text())
    .then(html => document.getElementById('sidebar').innerHTML = html);
    
