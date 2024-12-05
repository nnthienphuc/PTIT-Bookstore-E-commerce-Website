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

@Repository
public interface OrderRepository extends JpaRepository<Order, Long> {
	// Tìm theo tên người đặt
    @Query("SELECT o FROM Order o WHERE o.user.fullName LIKE %:buyerName%")
    Page<Order> findByBuyerName(@Param("buyerName") String buyerName, Pageable pageable);
      
    
    // Lọc theo trạng thái
    Page<Order> findByOrderStatus(String status, Pageable pageable);
    
    // Tìm kiếm kết hợp (đơn giản hóa)
 // Sử dụng JPQL
    @Query("SELECT o FROM Order o JOIN FETCH o.user u " +
           "WHERE (:keyword IS NULL OR " +
           "CAST(o.id AS string) LIKE %:keyword% OR " +
           "o.receiver LIKE %:keyword% OR " +
           "u.fullName LIKE %:keyword%) " +
           "AND (:status IS NULL OR o.orderStatus = :status)")
    Page<Order> searchOrders(
        @Param("keyword") String keyword,
        @Param("status") String status,
        Pageable pageable
    );
    
    // Đếm số lượng theo trạng thái
    Long countByOrderStatus(String status);
}