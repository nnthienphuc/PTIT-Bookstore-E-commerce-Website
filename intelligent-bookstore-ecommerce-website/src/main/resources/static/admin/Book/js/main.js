// Xử lý thêm sách
$('#addBookForm').on('submit', function(e) {
    e.preventDefault();
    
    let formData = new FormData(this);
    
    $.ajax({
        url: $(this).attr('action'),
        type: 'POST',
        data: formData,
        processData: false,
        contentType: false,
        success: function(response) {
            $('#addBookModal').modal('hide');
            Swal.fire({
                icon: 'success',
                title: 'Thành công',
                text: 'Thêm sách mới thành công!'
            }).then(() => {
                location.reload();
            });
        },
        error: function(xhr) {
            Swal.fire({
                icon: 'error',
                title: 'Lỗi',
                text: 'Có lỗi xảy ra khi thêm sách!'
            });
        }
    });
});

function editBook(isbn) {
    $.get(`/admin/book/${isbn}`, function(book) {
        // Điền thông tin cơ bản
        $('#editIsbn').val(book.isbn);
        $('#editTitle').val(book.title);
        $('#editAuthorId').val(book.authorId);
        $('#editCategoryId').val(book.categoryId);
        $('#editPublisherId').val(book.publisherId);
        $('#editYear').val(book.year_of_publication);
        $('#editQuantity').val(book.quantity);
        $('#editPrice').val(book.price);
        $('#editDiscountPercent').val(Math.round(book.discount_percent * 100));
        $('#editDescription').val(book.description);
        
        // Checkbox
        $('#editIsDiscontinued').prop('checked', book.is_discontinued);
        $('#editIsDiscount').prop('checked', book.is_discount);
        
        // Reset file input
        $('input[name="images"]').val('');
        $('.selected-count').text('0');
        
        // Hiển thị ảnh hiện tại
        let currentImages = `
            <div class="mb-2">
                <label class="form-label">Ảnh hiện tại:</label>
                <div class="d-flex gap-2">
                    <img src="/bookImage/${book.url1}" class="img-thumbnail" style="width: 100px">
                    <img src="/bookImage/${book.url2}" class="img-thumbnail" style="width: 100px">
                    <img src="/bookImage/${book.url3}" class="img-thumbnail" style="width: 100px">
                    <img src="/bookImage/${book.url4}" class="img-thumbnail" style="width: 100px">
                    <img src="/bookImage/${book.url5}" class="img-thumbnail" style="width: 100px">
                </div>
            </div>
        `;
        
        // Thêm vào trước input file
        $('input[name="images"]').before(currentImages);
        
        // Hiển thị modal
        $('#editBookModal').modal('show');
    })
    .fail(function(xhr) {
        Swal.fire({
            icon: 'error',
            title: 'Lỗi',
            text: 'Không thể lấy thông tin sách!'
        });
    });
}

// Xóa ảnh hiện tại khi đóng modal
$('#editBookModal').on('hidden.bs.modal', function () {
    $(this).find('form')[0].reset();
    $(this).find('.mb-2').remove(); // Xóa phần hiển thị ảnh
});

// Thêm vào phần xử lý submit form edit
$('#editBookForm').on('submit', function(e) {
    e.preventDefault();
    
    // Validate dữ liệu
    const yearInput = this.querySelector('input[name="year_of_publication"]');
    const year = parseInt(yearInput.value);
    const currentYear = new Date().getFullYear();
    
    if (year < 1900 || year > currentYear) {
        Swal.fire({
            icon: 'error',
            title: 'Lỗi',
            text: `Năm xuất bản phải từ 1900 đến ${currentYear}!`
        });
        return;
    }
    
    const quantity = parseInt(this.querySelector('input[name="quantity"]').value);
    if (quantity < 1) {
        Swal.fire({
            icon: 'error',
            title: 'Lỗi',
            text: 'Số lượng phải lớn hơn 0!'
        });
        return;
    }
    
    // Nếu có chọn ảnh mới thì validate
    const imageInput = this.querySelector('input[type="file"]');
    if (imageInput.files.length > 0 && !validateImages(imageInput)) {
        return;
    }
    
    let formData = new FormData(this);
    
    $.ajax({
        url: $(this).attr('action'),
        type: 'POST',
        data: formData,
        processData: false,
        contentType: false,
        success: function(response) {
            $('#editBookModal').modal('hide');
            Swal.fire({
                icon: 'success',
                title: 'Thành công',
                text: 'Cập nhật sách thành công!'
            }).then(() => {
                location.reload();
            });
        },
        error: function(xhr) {
            Swal.fire({
                icon: 'error',
                title: 'Lỗi',
                text: xhr.responseText || 'Có lỗi xảy ra khi cập nhật sách!'
            });
        }
    });
});

function deleteBook(isbn) {
    Swal.fire({
        title: 'Xác nhận xóa?',
        text: 'Bạn có chắc chắn muốn xóa tác giả này?',
        icon: 'warning',
        showCancelButton: true,
        confirmButtonText: 'Xóa',
        cancelButtonText: 'Hủy'
    }).then((result) => {
        if (result.isConfirmed) {
            fetch(`/admin/book/delete/${isbn}`, {
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

// Cập nhật số lượng
$('.quantity-input').on('change', function() {
    let isbn = $(this).data('isbn');
    let quantity = $(this).val();
    
    $.ajax({
        url: `/admin/book/update-quantity/${isbn}`,
        type: 'POST',
        data: { quantity: quantity },
        success: function() {
            Swal.fire({
                icon: 'success',
                title: 'Thành công',
                text: 'Cập nhật số lượng thành công!',
                timer: 1500
            });
        },
        error: function() {
            Swal.fire({
                icon: 'error',
                title: 'Lỗi',
                text: 'Có lỗi xảy ra khi cập nhật số lượng!'
            });
        }
    });
});

// Toggle trạng thái ngừng kinh doanh
$('.status-toggle').on('change', function() {
    let isbn = $(this).data('isbn');
    
    $.ajax({
        url: `/admin/book/toggles-status/${isbn}`,
        type: 'POST',
        success: function(response) {
            console.log('Cập nhật thành công:', response); // In ra thông tin sách đã cập nhật
            Swal.fire({
                icon: 'success',
                title: 'Thành công',
                text: 'Cập nhật trạng thái thành công!',
                timer: 1500
            });
        },
        error: function(xhr, status, error) {
            console.error('Có lỗi xảy ra:', error); // In ra thông điệp lỗi
            Swal.fire({
                icon: 'error',
                title: 'Lỗi',
                text: 'Có lỗi xảy ra khi cập nhật trạng thái!'
            });
        }
    });
});
function validateYear(input) {
    const year = parseInt(input.value);
    const currentYear = new Date().getFullYear();
    
    if (year < 1900 || year > currentYear) {
        input.setCustomValidity(`Năm xuất bản phải từ 1900 đến ${currentYear}`);
        input.reportValidity();
    } else {
        input.setCustomValidity('');
    }
}

// Thêm validate cho form
document.getElementById('addBookForm').addEventListener('submit', function(e) {
    const yearInput = this.querySelector('input[name="year_of_publication"]');
    const year = parseInt(yearInput.value);
    const currentYear = new Date().getFullYear();
    
    if (year < 1900 || year > currentYear) {
        e.preventDefault();
        Swal.fire({
            icon: 'error',
            title: 'Lỗi',
            text: `Năm xuất bản phải từ 1900 đến ${currentYear}!`
        });
    }
});

// Tương tự cho form edit
document.getElementById('editBookForm').addEventListener('submit', function(e) {
    const yearInput = this.querySelector('input[name="year_of_publication"]');
    const year = parseInt(yearInput.value);
    const currentYear = new Date().getFullYear();
    
    if (year < 1900 || year > currentYear) {
        e.preventDefault();
        Swal.fire({
            icon: 'error',
            title: 'Lỗi',
            text: `Năm xuất bản phải từ 1900 đến ${currentYear}!`
        });
    }
});
// Khởi tạo tooltips
var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'))
var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
    return new bootstrap.Tooltip(tooltipTriggerEl)
});

function validateImages(input) {
    const fileCount = input.files.length;
    const countDisplay = input.parentElement.querySelector('.selected-count');
    countDisplay.textContent = fileCount;
    
    if (fileCount !== 5) {
        input.setCustomValidity('Vui lòng chọn đủ 5 ảnh');
        input.reportValidity();
        // Reset input
        input.value = '';
        countDisplay.textContent = '0';
        
        Swal.fire({
            icon: 'error',
            title: 'Lỗi',
            text: 'Vui lòng chọn đủ 5 ảnh!',
            confirmButtonText: 'Chọn lại'
        });
        return false;
    }

    // Kiểm tra kích thước và định dạng
    let validFiles = true;
    const maxSize = 5 * 1024 * 1024; // 5MB
	const validTypes = [
	    'image/jpeg',     // .jpg, .jpeg
	    'image/png',      // .png
	    'image/gif',      // .gif
	    'image/webp',     // .webp
	    'image/bmp',      // .bmp
	    'image/tiff',     // .tiff, .tif
	    'image/svg+xml',  // .svg
	    'image/x-icon',   // .ico
	    'image/heic',     // .heic (iPhone)
	    'image/heif'      // .heif (iPhone)
	];
    
    Array.from(input.files).forEach(file => {
        if (file.size > maxSize) {
            validFiles = false;
            Swal.fire({
                icon: 'error',
                title: 'Lỗi',
                text: `File ${file.name} vượt quá 5MB!`,
                confirmButtonText: 'Chọn lại'
            });
        }
        if (!validTypes.includes(file.type)) {
            validFiles = false;
            Swal.fire({
                icon: 'error',
                title: 'Lỗi',
                text: `File ${file.name} không phải là ảnh hợp lệ!`,
                confirmButtonText: 'Chọn lại'
            });
        }
    });

    if (!validFiles) {
        input.value = '';
        countDisplay.textContent = '0';
        return false;
    }

    input.setCustomValidity('');
    return true;
}

// Validate form trước khi submit
document.getElementById('addBookForm').addEventListener('submit', function(e) {
    const imageInput = this.querySelector('input[type="file"]');
    if (!validateImages(imageInput)) {
        e.preventDefault();
    }
});

// Form edit - cho phép không chọn ảnh hoặc phải chọn đủ 5 ảnh
document.getElementById('editBookForm').addEventListener('submit', function(e) {
    const imageInput = this.querySelector('input[type="file"]');
    if (imageInput.files.length > 0 && !validateImages(imageInput)) {
        e.preventDefault();
    }
});


