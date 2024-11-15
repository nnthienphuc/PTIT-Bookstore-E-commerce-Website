package com.nnthienphuc.intelligentbookstoreecommercewebsite.repository;


import com.nnthienphuc.intelligentbookstoreecommercewebsite.entity.Book;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface BookRepository extends JpaRepository<Book, String> {
    // Tìm kiếm theo categoryName chứa keyword (không phân biệt hoa thường)
    List<Book> findByTitleContainingIgnoreCase(String keyword);
    List<Book> getBooksByAuthorID(Integer keyword);
}