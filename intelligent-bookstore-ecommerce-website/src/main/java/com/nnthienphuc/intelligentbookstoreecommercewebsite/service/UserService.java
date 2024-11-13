package com.nnthienphuc.intelligentbookstoreecommercewebsite.service;

import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import org.hibernate.SessionFactory;
import org.hibernate.Session;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Transactional
@Service
@RequiredArgsConstructor()

public class UserService {
    @Autowired
    SessionFactory sessionFactory;

}
