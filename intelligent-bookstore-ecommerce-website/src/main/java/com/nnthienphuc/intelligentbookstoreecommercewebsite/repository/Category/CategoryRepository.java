package com.nnthienphuc.intelligentbookstoreecommercewebsite.repository.Category;

import java.util.List;
import java.util.Locale.Category;
import java.util.Optional;
import java.util.function.Function;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Example;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.repository.query.FluentQuery.FetchableFluentQuery;
import org.springframework.stereotype.Repository;

import com.nnthienphuc.intelligentbookstoreecommercewebsite.entity.Category.CategoryEntity;

import jakarta.persistence.EntityManager;
import jakarta.persistence.NoResultException;
import jakarta.persistence.TypedQuery;

@Repository
public interface CategoryRepository extends JpaRepository<CategoryEntity, Long> {
	 // Tìm kiếm theo categoryName chứa keyword (không phân biệt hoa thường)
    List<CategoryEntity> findByCategoryNameContainingIgnoreCase(String keyword);
}