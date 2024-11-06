function loadHTML(id, file) {
    fetch(file)
    .then(response => response.text())
    .then(data => {
        document.getElementById(id).innerHTML = data;
    });
    }
// Load header and footer
loadHTML('NavBar', '../../Component/NavBar/NavBar.html');