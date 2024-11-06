package com.nnthienphuc.intelligentbookstoreecommercewebsite.service.Category;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.nnthienphuc.intelligentbookstoreecommercewebsite.entity.Category.CategoryEntity;
import com.nnthienphuc.intelligentbookstoreecommercewebsite.repository.Category.CategoryRepository;

import jakarta.transaction.Transactional;

@Service
public class CategoryService {

    @Autowired
    private CategoryRepository categoryRepository;

    // Lấy tất cả category
    public List<CategoryEntity> getAllCategories() {
        return categoryRepository.findAll();
    }

    // Lấy category theo ID
    public CategoryEntity getCategoryById(Long id) {
        Optional<CategoryEntity> category = categoryRepository.findById(id);
        return category.orElse(null);
    }

    // Thêm mới category
    @Transactional
    public CategoryEntity createCategory(CategoryEntity category) {
        // Kiểm tra tên category đã tồn tại chưa
        if (categoryRepository.existsByCategoryName(category.getCategoryName())) {
            throw new RuntimeException("Category name already exists");
        }
        return categoryRepository.save(category);
    }

    // Cập nhật category
    @Transactional
    public CategoryEntity updateCategory(Long id, CategoryEntity categoryDetails) {
        CategoryEntity category = getCategoryById(id);
        if (category == null) {
            throw new RuntimeException("Category not found with id: " + id);
        }

        // Kiểm tra nếu tên mới đã tồn tại và khác với tên hiện tại
        if (!category.getCategoryName().equals(categoryDetails.getCategoryName()) && 
            categoryRepository.existsByCategoryName(categoryDetails.getCategoryName())) {
            throw new RuntimeException("Category name already exists");
        }

        // Cập nhật thông tin
        category.setCategoryName(categoryDetails.getCategoryName());
        return categoryRepository.save(category);
    }

    // Xóa category
    @Transactional
    public void deleteCategory(Long id) {
        CategoryEntity category = getCategoryById(id);
        if (category == null) {
            throw new RuntimeException("Category not found with id: " + id);
        }
        
        // Có thể thêm kiểm tra ràng buộc trước khi xóa
        // Ví dụ: kiểm tra xem category có đang được sử dụng không
        
        categoryRepository.deleteById(id);
    }

    // Tìm category theo tên
    public CategoryEntity findByName(String name) {
        return categoryRepository.findByCategoryName(name);
    }

    // Kiểm tra category tồn tại theo ID
    public boolean existsById(Long id) {
        return categoryRepository.existsById(id);
    }
}