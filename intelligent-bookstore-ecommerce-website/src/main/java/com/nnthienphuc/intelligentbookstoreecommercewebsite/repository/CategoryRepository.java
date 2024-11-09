package com.nnthienphuc.intelligentbookstoreecommercewebsite.repository;


import com.nnthienphuc.intelligentbookstoreecommercewebsite.model.Category;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface CategoryRepository extends JpaRepository<Category, Integer> {
	 // Tìm kiếm theo categoryName chứa keyword (không phân biệt hoa thường)
     List<Category> findByCategoryNameContainingIgnoreCase(String keyword);
}