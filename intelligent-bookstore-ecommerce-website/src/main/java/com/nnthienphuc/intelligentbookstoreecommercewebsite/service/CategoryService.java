package com.nnthienphuc.intelligentbookstoreecommercewebsite.service;

import java.util.List;

import com.nnthienphuc.intelligentbookstoreecommercewebsite.model.Category;
import com.nnthienphuc.intelligentbookstoreecommercewebsite.repository.CategoryRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class CategoryService implements ICategoryService {

    @Autowired
    private CategoryRepository categoryRepository;


    public List<Category> getAllCategories() {
        return categoryRepository.findAll();
    }


    public Category getCategoryById(Integer id) {
        return categoryRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Không tìm thấy danh mục với id: " + id));
    }


    public Category saveCategory(Category category) {
        return categoryRepository.save(category);
    }


    public void deleteCategory(Integer id) {
        categoryRepository.deleteById(id);
    }
    public List<Category> searchByKeyword(String keyword) {
        if (keyword == null || keyword.trim().isEmpty()) {
            return categoryRepository.findAll(); // Trả về tất cả nếu keyword trống
        }
        return categoryRepository.findByCategoryNameContainingIgnoreCase(keyword.trim());
    }
}