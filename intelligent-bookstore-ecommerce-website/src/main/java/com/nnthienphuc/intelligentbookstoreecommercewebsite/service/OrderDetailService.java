package com.nnthienphuc.intelligentbookstoreecommercewebsite.service;

import com.nnthienphuc.intelligentbookstoreecommercewebsite.DTO.OrderDTO;
import com.nnthienphuc.intelligentbookstoreecommercewebsite.DTO.OrderDetailDTO;
import com.nnthienphuc.intelligentbookstoreecommercewebsite.entity.*;
import com.nnthienphuc.intelligentbookstoreecommercewebsite.repository.BookRepository;
import com.nnthienphuc.intelligentbookstoreecommercewebsite.repository.CartRepository;
import com.nnthienphuc.intelligentbookstoreecommercewebsite.repository.OrderDetailRepository;
import com.nnthienphuc.intelligentbookstoreecommercewebsite.repository.OrderRepository;
import jakarta.transaction.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.time.Instant;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Service
@Transactional
public class OrderDetailService {
    @Autowired
    private CartRepository cartRepository;

    @Autowired
    private OrderRepository orderRepository;
    @Autowired
    private OrderDetailRepository orderDetailRepository;
    @Autowired
    private BookRepository bookRepository;
    @Autowired
    private UserService userService;
    @Autowired
    private PromotionService promotionService;
    @Autowired
    private OrderService orderService;

    public List<List<OrderDetail>> laylistcaclistdetail(User user) {
      List<Order> orders =  orderService.findByUserId(user.getUserId());
      List<List<OrderDetail>> Details = new ArrayList<>();
      for (Order order : orders) {
          List<OrderDetail> orderDetails = orderDetailRepository.getAllByOrder(order.getOrderId());
          Details.add(orderDetails);
      }
      return Details;
    }
}