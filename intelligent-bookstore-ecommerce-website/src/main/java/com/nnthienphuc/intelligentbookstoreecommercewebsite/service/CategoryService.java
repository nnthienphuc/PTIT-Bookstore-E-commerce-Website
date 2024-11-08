package com.nnthienphuc.intelligentbookstoreecommercewebsite.service;

import java.util.List;

import com.nnthienphuc.intelligentbookstoreecommercewebsite.repository.CategoryRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.nnthienphuc.intelligentbookstoreecommercewebsite.entity.CategoryEntity;
import com.nnthienphuc.intelligentbookstoreecommercewebsite.repository.CategoryRepository;

@Service
public class CategoryService {

    @Autowired
    private CategoryRepository categoryRepository;


    public List<CategoryEntity> getAllCategories() {
        return categoryRepository.findAll();
    }


    public CategoryEntity getCategoryById(Long id) {
        return categoryRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Không tìm thấy danh mục với id: " + id));
    }


    public CategoryEntity saveCategory(CategoryEntity category) {
        return categoryRepository.save(category);
    }


    public void deleteCategory(Long id) {
        categoryRepository.deleteById(id);
    }
    public List<CategoryEntity> searchByKeyword(String keyword) {
        if (keyword == null || keyword.trim().isEmpty()) {
            return categoryRepository.findAll(); // Trả về tất cả nếu keyword trống
        }
        return categoryRepository.findByCategoryNameContainingIgnoreCase(keyword.trim());
    }
}