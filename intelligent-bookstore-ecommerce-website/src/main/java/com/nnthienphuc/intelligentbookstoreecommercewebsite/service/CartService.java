package com.nnthienphuc.intelligentbookstoreecommercewebsite.service;

import com.nnthienphuc.intelligentbookstoreecommercewebsite.entity.Book;
import com.nnthienphuc.intelligentbookstoreecommercewebsite.entity.Cart;
import com.nnthienphuc.intelligentbookstoreecommercewebsite.entity.User;
import com.nnthienphuc.intelligentbookstoreecommercewebsite.repository.BookRepository;
import com.nnthienphuc.intelligentbookstoreecommercewebsite.repository.CartRepository;
import com.nnthienphuc.intelligentbookstoreecommercewebsite.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
@Service
public class CartService {

    @Autowired
    private CartRepository cartRepository;

    @Autowired
    private  UserRepository userRepository;
    @Autowired
    private  BookRepository bookRepository;

    public CartService(CartRepository cartRepository,
                       UserRepository userRepository,
                       BookRepository bookRepository) {
        this.cartRepository = cartRepository;
        this.userRepository = userRepository;
        this.bookRepository = bookRepository;
    }

    public Cart createCartRecord(String userId, String isbn, short quantity) {
        User user = userRepository.findById(userId)
                .orElseThrow(() -> new IllegalArgumentException("Người dùng không tồn tại."));

        Book book = bookRepository.findById(isbn)
                .orElseThrow(() -> new IllegalArgumentException("Sách không tồn tại."));

        Cart cart = Cart.builder()
                .user(user)
                .isbn(book)
                .quantity(quantity)
                .build();

        return cartRepository.save(cart);
    }
    public List<Cart> getCartbyUserId(String userId) {
        return cartRepository.findByCustomerId(userId);
    }
    public Boolean isExist(String userId, String isbn) {
        if (cartRepository.findCartByUserIdAndIsbn(userId, isbn) == null)
            return false;
        return true;
    }
    public void updateCart(Short quantity, String userId, String isbn) {
        cartRepository.updateCartQuantity(quantity, userId, isbn);
    }
    public void deleteCart(String userId, String isbn) {
        cartRepository.deleteCartItem(userId, isbn);
    }

    public void removeItem(String userId, String isbn) {
        Cart cart = cartRepository.findCartByUserIdAndIsbn(userId, isbn);
        if (cart != null) {
            cartRepository.delete(cart);  // Xóa sản phẩm khỏi giỏ hàng
        }
    }

}
