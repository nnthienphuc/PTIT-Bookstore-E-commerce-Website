package com.nnthienphuc.intelligentbookstoreecommercewebsite.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.nnthienphuc.intelligentbookstoreecommercewebsite.entity.Author;
import com.nnthienphuc.intelligentbookstoreecommercewebsite.entity.Order;
import com.nnthienphuc.intelligentbookstoreecommercewebsite.entity.OrderDetail;

@Repository
public interface OrderDetailRepository extends JpaRepository<OrderDetail, Long> {
	 List<OrderDetail> findByOrder_Id(Long orderId);
}