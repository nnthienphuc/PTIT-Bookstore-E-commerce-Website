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
   
   function searchCategories() {
       console.log('Search function called'); // Debug log
       
       const searchInput = document.getElementById('searchInput');
       if (!searchInput) {
           console.error('Không tìm thấy element searchInput');
           return;
       }
       
       const searchTerm = searchInput.value;
       console.log('Search term:', searchTerm); // Debug log
       
       if (searchTerm.trim() === '') {
           window.location.reload();
           return;
       }

       // Log URL trước khi gọi API
       const searchUrl = `/admin/category/search?keyword=${encodeURIComponent(searchTerm)}`;
       console.log('Calling API:', searchUrl);

       fetch(searchUrl)
           .then(response => {
               console.log('Response status:', response.status); // Debug log
               if (!response.ok) {
                   throw new Error(`HTTP error! status: ${response.status}`);
               }
               return response.json();
           })
           .then(data => {
               console.log('Search results:', data); // Debug log
               
               const tableBody = document.querySelector('tbody');
               if (!tableBody) {
                   console.error('Không tìm thấy tbody');
                   return;
               }
               
               tableBody.innerHTML = '';
               
               if (data.length === 0) {
                   tableBody.innerHTML = `
                       <tr>
                           <td colspan="5" class="text-center">Không tìm thấy kết quả phù hợp</td>
                       </tr>
                   `;
                   return;
               }
               
               data.forEach((category, index) => {
                   tableBody.innerHTML += `
                       <tr>
                           <td>${index + 1}</td>
                           <td>${category.categoryId}</td>
                           <td>${category.categoryName}</td>
                           <td>${category.description || ''}</td>
                           <td>
                               <button class="btn btn-warning btn-sm" 
                                       onclick="editCategory(${category.categoryId})">Sửa</button>
                               <button class="btn btn-danger btn-sm" 
                                       onclick="deleteCategory(${category.categoryId})">Xóa</button>
                           </td>
                       </tr>
                   `;
               });
           })
           .catch(error => {
               console.error('Search error:', error); // Debug log
               Swal.fire({
                   icon: 'error',
                   title: 'Lỗi!',
                   text: 'Không thể tìm kiếm danh mục: ' + error.message
               });
           });
   }

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