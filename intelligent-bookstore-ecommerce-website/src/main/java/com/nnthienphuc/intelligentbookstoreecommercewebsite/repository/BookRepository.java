package com.nnthienphuc.intelligentbookstoreecommercewebsite.repository;


import com.nnthienphuc.intelligentbookstoreecommercewebsite.entity.Author;
import com.nnthienphuc.intelligentbookstoreecommercewebsite.entity.Book;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface BookRepository extends JpaRepository<Book, String> {
    // Tìm kiếm theo categoryName chứa keyword (không phân biệt hoa thường)
    List<Book> findByTitleContainingIgnoreCase(String keyword);

    @Query("SELECT b FROM Book b WHERE b.author_id.id = :authorId")
    List<Book> getBooksByAuthorID(@Param("authorId") Integer authorId);


}