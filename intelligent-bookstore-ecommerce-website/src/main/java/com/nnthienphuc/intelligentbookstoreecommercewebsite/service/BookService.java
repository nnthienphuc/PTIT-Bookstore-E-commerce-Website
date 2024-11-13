package com.nnthienphuc.intelligentbookstoreecommercewebsite.service;

import java.util.List;

import com.nnthienphuc.intelligentbookstoreecommercewebsite.entity.Book;
import com.nnthienphuc.intelligentbookstoreecommercewebsite.repository.BookRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class BookService {

    @Autowired
    private BookRepository bookRepository;


    public List<Book> getAllBook() {
        return bookRepository.findAll();
    }

    public Book getBookById(String id) {
        return bookRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Không tìm thấy sách với id: " + id));
    }


    public Book saveBook(Book book) {
        return bookRepository.save(book);
    }


    public void deleteBook(String id) {
        bookRepository.deleteById(id);
    }
    public List<Book> searchByKeyword(String keyword) {
        if (keyword == null || keyword.trim().isEmpty()) {
            return bookRepository.findAll(); // Trả về tất cả nếu keyword trống
        }
        return bookRepository.findByTitleContainingIgnoreCase(keyword.trim());
    }
}