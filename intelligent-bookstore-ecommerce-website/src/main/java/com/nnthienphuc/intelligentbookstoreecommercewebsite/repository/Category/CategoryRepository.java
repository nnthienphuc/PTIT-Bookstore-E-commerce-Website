package com.nnthienphuc.intelligentbookstoreecommercewebsite.repository.Category;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.nnthienphuc.intelligentbookstoreecommercewebsite.entity.CategoryEntity;

@Repository
public interface CategoryRepository extends JpaRepository<CategoryEntity, Long> {
	 // Tìm kiếm theo categoryName chứa keyword (không phân biệt hoa thường)
    List<CategoryEntity> findByCategoryNameContainingIgnoreCase(String keyword);
}