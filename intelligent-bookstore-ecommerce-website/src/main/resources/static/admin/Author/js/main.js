function editAuthor(id) {
    fetch(`/admin/author/${id}`)
        .then(response => response.json())
        .then(data => {
            document.getElementById('editAuthorId').value = data.authorId;
            document.getElementById('editAuthorName').value = data.authorName;
            
            // Hiển thị modal edit
            var editModal = new bootstrap.Modal(document.getElementById('editModal'));
            editModal.show();
        })
        .catch(error => {
            console.error('Chi tiết lỗi:', error);
            Swal.fire({
                icon: 'error',
                title: 'Lỗi!',
                html: `
                    <p>Có lỗi xảy ra khi lấy thông tin tác giả!</p>
                    <p style="color: red; font-size: 14px;">Chi tiết lỗi: ${error.toString()}</p>
                    <p style="font-size: 12px;">Status: ${error.status || 'N/A'}</p>
                `,
                confirmButtonText: 'Đóng'
            });
        });
}

function deleteAuthor(id) {
    Swal.fire({
        title: 'Xác nhận xóa?',
        text: 'Bạn có chắc chắn muốn xóa tác giả này?',
        icon: 'warning',
        showCancelButton: true,
        confirmButtonText: 'Xóa',
        cancelButtonText: 'Hủy'
    }).then((result) => {
        if (result.isConfirmed) {
            fetch(`/admin/author/delete/${id}`, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                }
            })
            .then(response => {
                if(response.ok) {
                    Swal.fire('Thành công!', 'Xóa tác giả thành công!', 'success')
                    .then(() => window.location.reload());
                } else {
                    Swal.fire('Lỗi!', 'Xóa tác giả thất bại!', 'error');
                }
            })
            .catch(error => {
                Swal.fire('Lỗi!', 'Có lỗi xảy ra khi xóa tác giả!', 'error');
            });
        }
    });
}

// Tự động đóng alert sau 3 giây
document.addEventListener('DOMContentLoaded', function() {
    // Xử lý cho alert success
    const successAlert = document.getElementById('successAlert');
    if (successAlert) {
        setTimeout(function() {
            const bsAlert = new bootstrap.Alert(successAlert);
            bsAlert.close();
        }, 3000);
    }
    
    // Xử lý cho alert error
    const errorAlert = document.getElementById('errorAlert');
    if (errorAlert) {
        setTimeout(function() {
            const bsAlert = new bootstrap.Alert(errorAlert);
            bsAlert.close();
        }, 3000);
    }
});

document.getElementById('button-search').addEventListener('click', function() {
    var keyword = document.getElementById('searchInput').value;
    window.location.href = '/admin/author?keyword=' + encodeURIComponent(keyword);
});

// Enter key trong input search
document.getElementById('searchInput').addEventListener('keypress', function(e) {
    if (e.key === 'Enter') {
        var keyword = this.value;
        window.location.href = '/admin/author?keyword=' + encodeURIComponent(keyword);
    }
});

