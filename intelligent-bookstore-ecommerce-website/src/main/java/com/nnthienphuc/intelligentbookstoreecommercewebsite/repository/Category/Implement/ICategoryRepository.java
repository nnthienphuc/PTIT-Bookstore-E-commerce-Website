package com.nnthienphuc.intelligentbookstoreecommercewebsite.repository.Category.Implement;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.nnthienphuc.intelligentbookstoreecommercewebsite.entity.Category.CategoryEntity;

@Repository
public interface ICategoryRepository extends JpaRepository<CategoryEntity, Long> {
    // Tìm category theo tên
    CategoryEntity findByCategoryName(String name);
    
    // Kiểm tra category có tồn tại theo tên
    boolean existsByCategoryName(String name);
}
