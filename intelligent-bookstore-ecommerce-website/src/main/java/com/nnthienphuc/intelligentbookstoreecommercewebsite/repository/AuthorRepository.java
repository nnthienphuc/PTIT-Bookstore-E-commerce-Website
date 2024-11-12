package com.nnthienphuc.intelligentbookstoreecommercewebsite.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.nnthienphuc.intelligentbookstoreecommercewebsite.entity.Author;

@Repository
public interface AuthorRepository extends JpaRepository<Author, Long> {
	 // Tìm kiếm theo categoryName chứa keyword (không phân biệt hoa thường)
    List<Author> findByAuthorNameContainingIgnoreCase(String keyword);
}
