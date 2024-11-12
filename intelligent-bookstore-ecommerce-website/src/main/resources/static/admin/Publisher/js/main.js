function editPublisher(id) {
    fetch(`/admin/publisher/${id}`)
        .then(response => response.json())
        .then(data => {
            document.getElementById('editPublisherId').value = data.publisherId;
            document.getElementById('editPublisherName').value = data.publisherName;
            
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
                    <p>Có lỗi xảy ra khi lấy thông tin nhà xuất bản!</p>
                    <p style="color: red; font-size: 14px;">Chi tiết lỗi: ${error.toString()}</p>
                    <p style="font-size: 12px;">Status: ${error.status || 'N/A'}</p>
                `,
                confirmButtonText: 'Đóng'
            });
        });
}

function deletePublisher(id) {
    Swal.fire({
        title: 'Xác nhận xóa?',
        text: 'Bạn có chắc chắn muốn xóa nhà xuất bản này?',
        icon: 'warning',
        showCancelButton: true,
        confirmButtonText: 'Xóa',
        cancelButtonText: 'Hủy'
    }).then((result) => {
        if (result.isConfirmed) {
            fetch(`/admin/publisher/delete/${id}`, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                }
            })
            .then(response => {
                if(response.ok) {
                    Swal.fire('Thành công!', 'Xóa nhà xuất bản thành công!', 'success')
                    .then(() => window.location.reload());
                } else {
                    Swal.fire('Lỗi!', 'Xóa nhà xuất bản thất bại!', 'error');
                }
            })
            .catch(error => {
                Swal.fire('Lỗi!', 'Có lỗi xảy ra khi xóa nhà xuất bản!', 'error');
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

function searchPublishers() {
    console.log('Search function called');
    
    const searchInput = document.getElementById('searchInput');
    if (!searchInput) {
        console.error('Không tìm thấy element searchInput');
        return;
    }
    
    const searchTerm = searchInput.value;
    console.log('Search term:', searchTerm);
    
    if (searchTerm.trim() === '') {
        window.location.reload();
        return;
    }

    const searchUrl = `/admin/publisher/search?keyword=${encodeURIComponent(searchTerm)}`;
    console.log('Calling API:', searchUrl);

    fetch(searchUrl)
        .then(response => {
            console.log('Response status:', response.status);
            if (!response.ok) {
                throw new Error(`HTTP error! status: ${response.status}`);
            }
            return response.json();
        })
        .then(data => {
            console.log('Search results:', data);
            
            const tableBody = document.querySelector('tbody');
            if (!tableBody) {
                console.error('Không tìm thấy tbody');
                return;
            }
            
            tableBody.innerHTML = '';
            
            if (data.length === 0) {
                tableBody.innerHTML = `
                    <tr>
                        <td colspan="4" class="text-center">Không tìm thấy kết quả phù hợp</td>
                    </tr>
                `;
                return;
            }
            
            data.forEach((publisher, index) => {
                tableBody.innerHTML += `
                    <tr>
                        <td>${index + 1}</td>
                        <td>${publisher.publisherId}</td>
                        <td>${publisher.publisherName}</td>
                        <td>
                            <button class="btn btn-warning btn-sm" 
                                    onclick="editPublisher(${publisher.publisherId})">Sửa</button>
                            <button class="btn btn-danger btn-sm" 
                                    onclick="deletePublisher(${publisher.publisherId})">Xóa</button>
                        </td>
                    </tr>
                `;
            });
        })
        .catch(error => {
            console.error('Search error:', error);
            Swal.fire({
                icon: 'error',
                title: 'Lỗi!',
                text: 'Không thể tìm kiếm nhà xuất bản: ' + error.message
            });
        });
}

// Đảm bảo event listeners được thêm sau khi DOM đã load
document.addEventListener('DOMContentLoaded', function() {
    const searchButton = document.getElementById('button-search');
    const searchInput = document.getElementById('searchInput');
    
    if (searchButton) {
        searchButton.addEventListener('click', function() {
            searchPublishers();
        });
    }
    
    if (searchInput) {
        searchInput.addEventListener('keypress', function(e) {
            if (e.key === 'Enter') {
                searchPublishers();
            }
        });
    }
});