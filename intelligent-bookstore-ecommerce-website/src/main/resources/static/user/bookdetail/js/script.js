// Xử lý tăng giảm số lượng
function decreaseQuantity() {
    const input = document.getElementById('quantity');
    if (input.value > 1) {
        input.value = parseInt(input.value) - 1;
    }
}

function increaseQuantity() {
    const input = document.getElementById('quantity');
    input.value = parseInt(input.value) + 1;
}

// Xử lý click vào thumbnail
document.addEventListener('DOMContentLoaded', function() {
    document.querySelectorAll('.thumbnail').forEach(thumb => {
        thumb.addEventListener('click', function() {
            // Xóa class active khỏi tất cả thumbnails
            document.querySelectorAll('.thumbnail').forEach(t => t.classList.remove('active'));
            // Thêm class active vào thumbnail được click
            this.classList.add('active');
            // Cập nhật ảnh chính
            document.querySelector('.main-image').src = this.src.replace('80/80', '400/600');
        });
    });

    // Thêm xử lý click cho nút thêm vào giỏ hàng
    document.querySelector('.add-to-cart').addEventListener('click', function() {
        alert('Đã thêm sản phẩm vào giỏ hàng!');
    });

    // Thêm xử lý click cho nút mua ngay
    document.querySelector('.buy-now').addEventListener('click', function() {
        alert('Chuyển đến trang thanh toán!');
    });
});

document.addEventListener('DOMContentLoaded', function() {
    const slider = document.querySelector('.product-cards');
    const prevBtn = document.querySelector('.slider-btn.prev');
    const nextBtn = document.querySelector('.slider-btn.next');
    const cardWidth = 216; // 200px width + 16px gap
    let currentPosition = 0;

    prevBtn.addEventListener('click', () => {
        currentPosition = Math.min(currentPosition + cardWidth, 0);
        updateSliderPosition();
    });

    nextBtn.addEventListener('click', () => {
        const maxScroll = -(slider.scrollWidth - slider.clientWidth);
        currentPosition = Math.max(currentPosition - cardWidth, maxScroll);
        updateSliderPosition();
    });

    function updateSliderPosition() {
        slider.style.transform = `translateX(${currentPosition}px)`;
    }

    // Thêm transition cho smooth scrolling
    slider.style.transition = 'transform 0.3s ease';
});

