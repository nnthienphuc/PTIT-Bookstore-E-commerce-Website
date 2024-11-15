function editCategory(id) {
    fetch(`/admin/category/${id}`)
        .then(response => response.json())
        .then(data => {
            document.getElementById('editCategoryId').value = data.categoryId;
            document.getElementById('editCategoryName').value = data.categoryName;
            
            // Hiển thị modal edit
            var editModal = new bootstrap.Modal(document.getElementById('editModal'));
            editModal.show();
        })
        .catch(error => {
			console.error('Chi tiết lỗi:', error); // Log lỗi ra console
			            Swal.fire({
			                icon: 'error',
			                title: 'Lỗi!',
			                html: `
			                    <p>Có lỗi xảy ra khi lấy thông tin danh mục!</p>
			                    <p style="color: red; font-size: 14px;">Chi tiết lỗi: ${error.toString()}</p>
			                    <p style="font-size: 12px;">Status: ${error.status || 'N/A'}</p>
			                `,
			                confirmButtonText: 'Đóng'
			            });
        });
}

function deleteCategory(id) {
    if(confirm('Bạn có chắc chắn muốn xóa danh mục này?')) {
        fetch(`/admin/category/delete/${id}`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            }
        })
        .then(response => {
            if(response.ok) {
                alert('Xóa danh mục thành công!');
                window.location.reload();
            } else {
                alert('Xóa danh mục thất bại!');
            }
        })
        .catch(error => {
            alert('Có lỗi xảy ra khi xóa danh mục!');
        });
    }
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
       window.location.href = '/admin/category?keyword=' + encodeURIComponent(keyword);
   });

   // Enter key trong input search
   document.getElementById('searchInput').addEventListener('keypress', function(e) {
       if (e.key === 'Enter') {
           var keyword = this.value;
           window.location.href = '/admin/category?keyword=' + encodeURIComponent(keyword);
       }
   });

   // Đảm bảo event listeners được thêm sau khi DOM đã load
   document.addEventListener('DOMContentLoaded', function() {
       
       
       const searchButton = document.getElementById('button-search');
       const searchInput = document.getElementById('searchInput');
       
       if (searchButton) {
          
           searchButton.addEventListener('click', function() {
            
               searchCategories();
           });
       } 
       if (searchInput) {
          
           searchInput.addEventListener('keypress', function(e) {
               if (e.key === 'Enter') {
                  
                   searchCategories();
               }
           });
       }
   });