function loadHTML(id, file) {
    fetch(file)
    .then(response => response.text())
    .then(data => {
        document.getElementById(id).innerHTML = data;
    });
    }
// Load header and footer
loadHTML('NavBar', '../../Component/NavBar/NavBar.html');

// Hàm mở modal
function openModal(id) {
    document.getElementById("addModal").style.display = "block";
    if(id == null){
        document.getElementById("Title").textContent = "Thêm mới";
    }else{
        document.getElementById("Title").textContent = "Sửa";
    }

}

// Hàm đóng modal
function closeModal() {
    document.getElementById("addModal").style.display = "none";
}

// Hàm lưu dữ liệu (ví dụ)
function saveData() {
    const id = document.getElementById("inputId").value;
    const name = document.getElementById("inputName").value;
    console.log("Mã Thể Loại:", id);
    console.log("Tên Thể Loại:", name);
    closeModal(); // Đóng modal sau khi lưu
}

// Đóng modal khi người dùng nhấp bên ngoài
window.onclick = function(event) {
    const modal = document.getElementById("addModal");
    if (event.target == modal) {
        closeModal();
    }
}