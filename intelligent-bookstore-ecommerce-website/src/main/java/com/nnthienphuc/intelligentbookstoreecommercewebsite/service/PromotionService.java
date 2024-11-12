package com.nnthienphuc.intelligentbookstoreecommercewebsite.service;

import java.util.List;

import com.nnthienphuc.intelligentbookstoreecommercewebsite.repository.PromotionRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.nnthienphuc.intelligentbookstoreecommercewebsite.entity.Promotion;
import com.nnthienphuc.intelligentbookstoreecommercewebsite.repository.PromotionRepository;

@Service
public class PromotionService {

    @Autowired
    private PromotionRepository PromotionRepository;


    public List<Promotion> getAllPromotions() {
        return PromotionRepository.findAll();
    }


    public Promotion getPromotionById(Long id) {
        return PromotionRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Không tìm thấy danh mục với id: " + id));
    }


    public Promotion savePromotion(Promotion Promotion) {
        return PromotionRepository.save(Promotion);
    }


    public void deletePromotion(Long id) {
        PromotionRepository.deleteById(id);
    }
    public List<Promotion> searchByKeyword(String keyword) {
        if (keyword == null || keyword.trim().isEmpty()) {
            return PromotionRepository.findAll(); // Trả về tất cả nếu keyword trống
        }
        return PromotionRepository.findByPromotionNameContainingIgnoreCase(keyword.trim());
    }
}