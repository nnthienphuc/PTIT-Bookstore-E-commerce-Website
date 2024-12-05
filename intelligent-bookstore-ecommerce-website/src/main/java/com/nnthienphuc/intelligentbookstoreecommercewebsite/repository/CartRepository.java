package com.nnthienphuc.intelligentbookstoreecommercewebsite.repository;

import com.nnthienphuc.intelligentbookstoreecommercewebsite.entity.Cart;
import org.springframework.data.jpa.repository.JpaRepository;

public interface CartRepository extends JpaRepository<Cart, Integer> {
}
