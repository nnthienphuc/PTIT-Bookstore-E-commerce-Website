package com.nnthienphuc.intelligentbookstoreecommercewebsite.service;

import com.nnthienphuc.intelligentbookstoreecommercewebsite.entity.History;
import com.nnthienphuc.intelligentbookstoreecommercewebsite.entity.SatisfyProduct;
import com.nnthienphuc.intelligentbookstoreecommercewebsite.repository.HistoryRepository;
import jakarta.persistence.EntityManager;
import jakarta.transaction.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class HistoryService {
    @Autowired
    private HistoryRepository historyRepository;

    @Autowired
    private EntityManager entityManager;

    public void save(History history) {
        historyRepository.save(history);
    }
}
