function editPromotion(id) {
    fetch(`/admin/promotion/${id}`)
        .then(response => response.json())
        .then(data => {
            document.getElementById('editPromotionId').value = data.promotionId;
            document.getElementById('editPromotionName').value = data.promotionName;
            document.getElementById('editStartDate').value = formatDateTimeForInput(data.startDate);
            document.getElementById('editEndDate').value = formatDateTimeForInput(data.endDate);
            document.getElementById('editCondition').value = data.condition;
            document.getElementById('editDiscountPercent').value = data.discountPercent;
            
            var editModal = new bootstrap.Modal(document.getElementById('editModal'));
            editModal.show();
        })
        .catch(error => {
            console.error('Chi tiết lỗi:', error);
            Swal.fire({
                icon: 'error',
                title: 'Lỗi!',
                html: `
                    <p>Có lỗi xảy ra khi lấy thông tin khuyến mãi!</p>
                    <p style="color: red; font-size: 14px;">Chi tiết lỗi: ${error.toString()}</p>
                    <p style="font-size: 12px;">Status: ${error.status || 'N/A'}</p>
                `,
                confirmButtonText: 'Đóng'
            });
        });
}

// Hàm format datetime cho input
function formatDateTimeForInput(dateTimeString) {
    if (!dateTimeString) return '';
    const date = new Date(dateTimeString);
    return date.toISOString().slice(0, 16); // Format: YYYY-MM-DDTHH:mm
}

// Hàm format datetime cho hiển thị
function formatDateTime(dateTimeString) {
    if (!dateTimeString) return '';
    const date = new Date(dateTimeString);
    return date.toLocaleString('vi-VN', {
        day: '2-digit',
        month: '2-digit',
        year: 'numeric',
        hour: '2-digit',
        minute: '2-digit'
    });
}

// Hàm format số tiền
function formatCurrency(amount) {
    return new Intl.NumberFormat('vi-VN', {
        style: 'currency',
        currency: 'VND'
    }).format(amount);
}

function searchPromotions() {
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

    const searchUrl = `/admin/promotion/search?keyword=${encodeURIComponent(searchTerm)}`;
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
                        <td colspan="8" class="text-center">Không tìm thấy kết quả phù hợp</td>
                    </tr>
                `;
                return;
            }
            
            data.forEach((promotion, index) => {
                // Format date và currency
                const startDate = formatDateTime(promotion.startDate);
                const endDate = formatDateTime(promotion.endDate);
                const condition = formatCurrency(promotion.condition);
                
                // Kiểm tra trạng thái khuyến mãi
                const now = new Date();
                const promotionStart = new Date(promotion.startDate);
                const promotionEnd = new Date(promotion.endDate);
                
                let status = '';
                let statusClass = '';
                
                if (now < promotionStart) {
                    status = 'Sắp diễn ra';
                    statusClass = 'text-warning';
                } else if (now > promotionEnd) {
                    status = 'Đã kết thúc';
                    statusClass = 'text-danger';
                } else {
                    status = 'Đang diễn ra';
                    statusClass = 'text-success';
                }

                tableBody.innerHTML += `
                    <tr>
                        <td>${index + 1}</td>
                        <td>${promotion.promotionId}</td>
                        <td>${promotion.promotionName}</td>
                        <td>${startDate}</td>
                        <td>${endDate}</td>
                        <td>${condition}</td>
                        <td>${promotion.discountPercent}%</td>
                        <td><span class="${statusClass}">${status}</span></td>
                        <td>
                            <button class="btn btn-warning btn-sm" 
                                    onclick="editPromotion(${promotion.promotionId})"
                                    ${now > promotionEnd ? 'disabled' : ''}>
                                    Sửa
                            </button>
                            <button class="btn btn-danger btn-sm" 
                                    onclick="deletePromotion(${promotion.promotionId})"
                                    ${now > promotionEnd ? 'disabled' : ''}>
                                    Xóa
                            </button>
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
                text: 'Không thể tìm kiếm khuyến mãi: ' + error.message
            });
        });
}
function deletePromotion(id) {
    // Kiểm tra trạng thái khuyến mãi trước khi xóa
    fetch(`/admin/promotion/${id}`)
        .then(response => response.json())
        .then(promotion => {
            const now = new Date();
            const endDate = new Date(promotion.endDate);
            
            if (now > endDate) {
                Swal.fire({
                    icon: 'error',
                    title: 'Không thể xóa!',
                    text: 'Không thể xóa khuyến mãi đã kết thúc!'
                });
                return;
            }
            
            // Nếu khuyến mãi chưa kết thúc, hiện dialog xác nhận
            Swal.fire({
                title: 'Xác nhận xóa?',
                html: `
                    <div class="text-left">
                        <p>Bạn có chắc chắn muốn xóa khuyến mãi này?</p>
                        <p><strong>Tên khuyến mãi:</strong> ${promotion.promotionName}</p>
                        <p><strong>Thời gian:</strong> ${formatDateTime(promotion.startDate)} - ${formatDateTime(promotion.endDate)}</p>
                        <p><strong>Điều kiện:</strong> ${formatCurrency(promotion.condition)}</p>
                        <p><strong>Giảm giá:</strong> ${promotion.discountPercent}%</p>
                    </div>
                `,
                icon: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#d33',
                cancelButtonColor: '#3085d6',
                confirmButtonText: 'Xóa',
                cancelButtonText: 'Hủy',
                customClass: {
                    confirmButton: 'btn btn-danger',
                    cancelButton: 'btn btn-secondary'
                }
            }).then((result) => {
                if (result.isConfirmed) {
                    // Gửi request xóa
                    fetch(`/admin/promotion/delete/${id}`, {
                        method: 'POST',
                        headers: {
                            'Content-Type': 'application/json',
                            'X-CSRF-TOKEN': document.querySelector('meta[name="_csrf"]')?.content
                        }
                    })
                    .then(response => {
                        if (!response.ok) {
                            throw new Error('Network response was not ok');
                        }
                        return response.text();
                    })
                    .then(result => {
                        console.log('Delete result:', result);
                        
                        Swal.fire({
                            icon: 'success',
                            title: 'Đã xóa!',
                            text: 'Xóa khuyến mãi thành công!',
                            showConfirmButton: false,
                            timer: 1500
                        }).then(() => {
                            // Refresh data
                            const searchInput = document.getElementById('searchInput');
                            if (searchInput && searchInput.value.trim() !== '') {
                                searchPromotions(); // Refresh search results
                            } else {
                                window.location.reload(); // Reload page if no search
                            }
                        });
                    })
                    .catch(error => {
                        console.error('Delete error:', error);
                        Swal.fire({
                            icon: 'error',
                            title: 'Lỗi!',
                            html: `
                                <p>Không thể xóa khuyến mãi!</p>
                                <p style="color: red; font-size: 14px;">Chi tiết lỗi: ${error.message}</p>
                            `,
                            confirmButtonText: 'Đóng'
                        });
                    });
                }
            });
        })
        .catch(error => {
            console.error('Error fetching promotion details:', error);
            Swal.fire({
                icon: 'error',
                title: 'Lỗi!',
                text: 'Không thể lấy thông tin khuyến mãi!'
            });
        });
}

// Hàm hỗ trợ format datetime (nếu chưa có)
function formatDateTime(dateTimeString) {
    if (!dateTimeString) return '';
    const date = new Date(dateTimeString);
    return date.toLocaleString('vi-VN', {
        day: '2-digit',
        month: '2-digit',
        year: 'numeric',
        hour: '2-digit',
        minute: '2-digit'
    });
}

// Hàm hỗ trợ format currency (nếu chưa có)
function formatCurrency(amount) {
    return new Intl.NumberFormat('vi-VN', {
        style: 'currency',
        currency: 'VND'
    }).format(amount);
}
// Hàm format datetime
function formatDateTime(dateTimeString) {
    if (!dateTimeString) return '';
    const date = new Date(dateTimeString);
    return date.toLocaleString('vi-VN', {
        day: '2-digit',
        month: '2-digit',
        year: 'numeric',
        hour: '2-digit',
        minute: '2-digit'
    });
}

// Hàm format currency
function formatCurrency(amount) {
    return new Intl.NumberFormat('vi-VN', {
        style: 'currency',
        currency: 'VND'
    }).format(amount);
}

// Thêm event listeners
document.addEventListener('DOMContentLoaded', function() {
    const searchButton = document.getElementById('button-search');
    const searchInput = document.getElementById('searchInput');
    
    if (searchButton) {
        searchButton.addEventListener('click', function() {
            searchPromotions();
        });
    }
    
    if (searchInput) {
        searchInput.addEventListener('keypress', function(e) {
            if (e.key === 'Enter') {
                searchPromotions();
            }
        });

        // Thêm debounce để tránh gọi API quá nhiều
        let timeoutId;
        searchInput.addEventListener('input', function() {
            clearTimeout(timeoutId);
            timeoutId = setTimeout(() => {
                if (this.value.trim() !== '') {
                    searchPromotions();
                }
            }, 500);
        });
    }
});
// Validate form trước khi submit
function validatePromotionForm(formId) {
    const form = document.getElementById(formId);
    const startDate = new Date(form.querySelector('[name="startDate"]').value);
    const endDate = new Date(form.querySelector('[name="endDate"]').value);
    const condition = parseFloat(form.querySelector('[name="condition"]').value);
    const discountPercent = parseFloat(form.querySelector('[name="discountPercent"]').value);

    if (endDate <= startDate) {
        Swal.fire({
            icon: 'error',
            title: 'Lỗi!',
            text: 'Ngày kết thúc phải sau ngày bắt đầu!'
        });
        return false;
    }

    if (condition < 0) {
        Swal.fire({
            icon: 'error',
            title: 'Lỗi!',
            text: 'Điều kiện phải là số dương!'
        });
        return false;
    }

    if (discountPercent < 0 || discountPercent > 100) {
        Swal.fire({
            icon: 'error',
            title: 'Lỗi!',
            text: 'Phần trăm giảm giá phải từ 0 đến 100!'
        });
        return false;
    }

    return true;
}

// Thêm event listeners cho form submit
document.addEventListener('DOMContentLoaded', function() {
    const addForm = document.querySelector('#addModal form');
    const editForm = document.querySelector('#editModal form');

    if (addForm) {
        addForm.addEventListener('submit', function(e) {
            if (!validatePromotionForm('addModal')) {
                e.preventDefault();
            }
        });
    }

    if (editForm) {
        editForm.addEventListener('submit', function(e) {
            if (!validatePromotionForm('editModal')) {
                e.preventDefault();
            }
        });
    }

    // ... existing event listeners ...
});