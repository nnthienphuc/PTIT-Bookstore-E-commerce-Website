package com.nnthienphuc.intelligentbookstoreecommercewebsite.service;

import java.util.List;

import com.nnthienphuc.intelligentbookstoreecommercewebsite.repository.PublisherRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.nnthienphuc.intelligentbookstoreecommercewebsite.entity.Publisher;
import com.nnthienphuc.intelligentbookstoreecommercewebsite.repository.PublisherRepository;

@Service
public class PublisherService {

    @Autowired
    private PublisherRepository PublisherRepository;


    public List<Publisher> getAllPublishers() {
        return PublisherRepository.findAll();
    }


    public Publisher getPublisherById(Long id) {
        return PublisherRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Không tìm thấy danh mục với id: " + id));
    }


    public Publisher savePublisher(Publisher Publisher) {
        return PublisherRepository.save(Publisher);
    }


    public void deletePublisher(Long id) {
        PublisherRepository.deleteById(id);
    }
    public List<Publisher> searchByKeyword(String keyword) {
        if (keyword == null || keyword.trim().isEmpty()) {
            return PublisherRepository.findAll(); // Trả về tất cả nếu keyword trống
        }
        return PublisherRepository.findByPublisherNameContainingIgnoreCase(keyword.trim());
    }
}