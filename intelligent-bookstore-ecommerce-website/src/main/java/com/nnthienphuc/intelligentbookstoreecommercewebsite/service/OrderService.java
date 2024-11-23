package com.nnthienphuc.intelligentbookstoreecommercewebsite.service;

import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.stream.Collectors;

import com.nnthienphuc.intelligentbookstoreecommercewebsite.repository.OrderDetailRepository;
import com.nnthienphuc.intelligentbookstoreecommercewebsite.repository.OrderRepository;

import jakarta.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.data.web.SpringDataWebProperties.Sort;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import com.nnthienphuc.intelligentbookstoreecommercewebsite.entity.Order;
import com.nnthienphuc.intelligentbookstoreecommercewebsite.entity.OrderDetail;
import com.nnthienphuc.intelligentbookstoreecommercewebsite.model.OrderStatus;
import com.nnthienphuc.intelligentbookstoreecommercewebsite.repository.OrderRepository;

@Service
@Transactional
public class OrderService {
    
    @Autowired
    private OrderRepository orderRepository;
    
    // Tìm theo tên người đặt
    public Page<Order> findByBuyerName(String buyerName, Pageable pageable) {
        return orderRepository.findByBuyerName(buyerName, pageable);
    }
    
    // Lọc theo trạng thái
    public Page<Order> findByStatus(String status, Pageable pageable) {
        return orderRepository.findByOrderStatus(status, pageable);
    }
    
    // Cập nhật trạng thái
    public Order updateStatus(Long orderId, String newStatus) {
        Order order = orderRepository.findById(orderId)
            .orElseThrow(() -> new RuntimeException("Không tìm thấy đơn hàng"));
            
        // Kiểm tra trạng thái hợp lệ
        if (!OrderStatus.getAllStatuses().contains(newStatus)) {
            throw new IllegalArgumentException("Trạng thái không hợp lệ");
        }
        
        order.setOrderStatus(newStatus);
        return orderRepository.save(order);
    }
    
    // Tìm kiếm kết hợp
    public Page<Order> searchOrders(String keyword, String status, Pageable pageable) {
        return orderRepository.searchOrders(keyword, status, pageable);
    }
}