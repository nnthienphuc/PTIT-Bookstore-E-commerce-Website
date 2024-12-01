package com.nnthienphuc.intelligentbookstoreecommercewebsite.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.nnthienphuc.intelligentbookstoreecommercewebsite.entity.Author;

@Repository
public interface AuthorRepository extends JpaRepository<Author, Long> {
	 // Tìm kiếm theo categoryName chứa keyword (không phân biệt hoa thường)
	 Page<Author> findByAuthorNameContainingIgnoreCase(String keyword, Pageable pageable);
    // Optional: Nên dùng Optional để xử lý null safety
    Optional<Author> findById(Long categoryId);
}
