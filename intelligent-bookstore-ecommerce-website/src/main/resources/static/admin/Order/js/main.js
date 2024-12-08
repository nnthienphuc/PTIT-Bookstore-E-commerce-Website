function updateStatus(id) {
    document.getElementById('editOrderId').value = id;
    // Hiển thị modal edit
    var editModal = new bootstrap.Modal(document.getElementById('updateStatusModal'));
    editModal.show();       
}

function viewOrder(id) {
	$.get(`/admin/order/${id}`, function(book) {
	       
	          // Điền thông tin vào modal
	          $('#orderId').text(book.orderId);
	          $('#userName').text(book.userName);
	          $('#promotionName').text(book.promotionName);
	          $('#orderDate').text(new Date(book.orderDate).toLocaleDateString());
	          $('#receiver').text(book.receiver);
	          $('#address').text(book.address);
	          $('#paymentMethod').text(book.paymentMethod);
			  let orderStatusHtml = '';
			        switch (book.orderStatus) {
			          case 'PENDING':
			            orderStatusHtml = '<span class="badge bg-warning">Chờ xác nhận</span>';
			            break;
			          case 'CONFIRMED':
			            orderStatusHtml = '<span class="badge bg-info">Đã xác nhận</span>';
			            break;
			          case 'IN_PROGRESS':
			            orderStatusHtml = '<span class="badge bg-primary">Đang giao</span>';
			            break;
			          case 'DELIVERED':
			            orderStatusHtml = '<span class="badge bg-success">Đã giao</span>';
			            break;
			          case 'CANCELED':
			            orderStatusHtml = '<span class="badge bg-danger">Đã hủy</span>';
			            break;
			          default:
			            orderStatusHtml = '<span class="badge bg-secondary">Chưa xác định</span>';
			        }
			        $('#orderStatus').html(orderStatusHtml);
	          $('#totalPrice').text(book.totalPrice.toLocaleString() + ' VND');

	          // Cập nhật thông tin sản phẩm
			  // Hiển thị danh sách sản phẩm
			  const productList = $('#productList');
			        productList.empty(); // Xóa nội dung cũ trước khi thêm mới
			        book.bookName.forEach((name, index) => {
			          const productHtml = `
			            <div class="book-item">
			              <img src="/bookImage/${book.bookImg[index]}" alt="Sách">
			              <div class="book-details">
			                <h6>${name}</h6>
			                <p><strong>Số Lượng:</strong> ${book.quantity[index]}</p>
			                <p><strong>Giá Tiền:</strong> ${book.price[index].toLocaleString()} VND</p>
			              </div>
			            </div>
			          `;
			          productList.append(productHtml);
			        });
			  $('#orderModal').modal('show');
	      }).fail(function() {
	        alert("Không thể tải thông tin đơn hàng!");
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

