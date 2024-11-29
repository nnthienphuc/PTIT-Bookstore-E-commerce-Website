package com.nnthienphuc.intelligentbookstoreecommercewebsite.service;

import java.util.List;

import com.nnthienphuc.intelligentbookstoreecommercewebsite.repository.PublisherRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import com.nnthienphuc.intelligentbookstoreecommercewebsite.entity.Author;
import com.nnthienphuc.intelligentbookstoreecommercewebsite.entity.Publisher;
import com.nnthienphuc.intelligentbookstoreecommercewebsite.repository.PublisherRepository;

@Service
public class PublisherService {

    @Autowired
    private PublisherRepository PublisherRepository;


    public Page<Publisher> getAllPublishers(Pageable pageable) {
        return PublisherRepository.findAll(pageable);
    }
    public List<Publisher> getAllPublishersNoPaging() {
        return PublisherRepository.findAll();
    }
    
    public Page<Publisher> searchPublishers(String keyword, Pageable pageable) {
        return PublisherRepository.findByPublisherNameContainingIgnoreCase(keyword, pageable);
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
   
}