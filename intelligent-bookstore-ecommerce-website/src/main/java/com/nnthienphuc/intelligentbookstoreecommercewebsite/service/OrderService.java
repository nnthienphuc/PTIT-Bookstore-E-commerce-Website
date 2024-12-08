package com.nnthienphuc.intelligentbookstoreecommercewebsite.service;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.time.Instant;
import java.time.LocalDate;
import java.time.ZoneId;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.stream.Collectors;

import com.nnthienphuc.intelligentbookstoreecommercewebsite.repository.BookRepository;
import com.nnthienphuc.intelligentbookstoreecommercewebsite.repository.OrderDetailRepository;
import com.nnthienphuc.intelligentbookstoreecommercewebsite.DTO.RevenueDetailsDTO;
import com.nnthienphuc.intelligentbookstoreecommercewebsite.repository.OrderRepository;

import jakarta.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.data.web.SpringDataWebProperties.Sort;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import com.nnthienphuc.intelligentbookstoreecommercewebsite.DTO.OrderDTO;
import com.nnthienphuc.intelligentbookstoreecommercewebsite.DTO.OrderDetailDTO;
import com.nnthienphuc.intelligentbookstoreecommercewebsite.entity.Author;
import com.nnthienphuc.intelligentbookstoreecommercewebsite.entity.Book;
import com.nnthienphuc.intelligentbookstoreecommercewebsite.entity.Category;
import com.nnthienphuc.intelligentbookstoreecommercewebsite.entity.Order;
import com.nnthienphuc.intelligentbookstoreecommercewebsite.entity.OrderDetail;
import com.nnthienphuc.intelligentbookstoreecommercewebsite.model.OrderStatus;
import com.nnthienphuc.intelligentbookstoreecommercewebsite.repository.OrderRepository;

@Service
@Transactional
public class OrderService {
    
    @Autowired
    private OrderRepository orderRepository;
    @Autowired
    private OrderDetailRepository orderDetailRepository;
    @Autowired
    private BookRepository bookRepository;
    
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
//        if (!OrderStatus.getAllStatuses().contains(newStatus)) {
//            throw new IllegalArgumentException("Trạng thái không hợp lệ");
//        }
        
        order.setOrderStatus(newStatus);
        return orderRepository.save(order);
    }
    
    // Tìm kiếm kết hợp
//    public Page<OrderDTO> searchOrders(Long orderId,String keyword, String status, Pageable pageable) {
//        return orderRepository.searchOrders(orderId, keyword, status, pageable);
//    }
    public Page<OrderDTO> getAllOrders(Pageable pageable) {
        Page<Order> order = orderRepository.findAll(pageable);
        return convertToOrderDTOPage(order);
    }
    public Page<OrderDTO> convertToOrderDTOPage(Page<Order> orderPage) {
        List<OrderDTO> orderDTOs = orderPage.getContent().stream()
            .map(order -> new OrderDTO(
                order.getOrderId(),
                order.getUser().getFullName(), // Giả sử có phương thức getUser() trong Order
                order.getPromotion().getPromotionName(), // Giả sử có phương thức getPromotion() trong Order
                order.getOrderDate(),
                order.getReceiver(),
                order.getAddress(),
                order.getPaymentMethod(),
                order.getOrderStatus(),
                order.getTotalPrice()
            ))
            .collect(Collectors.toList());

        return new PageImpl<>(orderDTOs, orderPage.getPageable(), orderPage.getTotalElements());
    }
    public Map<String, Long> getOrderCountByStatus() {
        List<Object[]> results = orderRepository.countOrdersByStatus();
        Map<String, Long> orderCountMap = new HashMap<>();

        for (Object[] result : results) {
            String status = (String) result[0];
            Long count = (Long) result[1];
            orderCountMap.put(status, count);
        }

        return orderCountMap;
    }
    public Page<OrderDTO> searchOrders(String keyword, String orderStatus, Pageable pageable) {
        try {
          
            // Tìm kiếm với các điều kiện khác nhau
            if (keyword == null && orderStatus == null) {
                return  convertToOrderDTOPage(orderRepository.findAll(pageable));
            }else
            {
            	return convertToOrderDTOPage(orderRepository.findByReceiverContainingIgnoreCaseAndOrderStatusContainingIgnoreCase(keyword,orderStatus,  pageable));
            }	
        } catch (Exception e) {
            throw new RuntimeException("Error searching books", e);
        }
    }

    public void changeStatus(Long orderId,String orderStatus) {
    	try {
    		if(orderId != null) {
    			Order order = orderRepository.getById(orderId);
    			order.setOrderStatus(orderStatus);
    			orderRepository.save(order);
    		}
    		
    	}  catch (Exception e) {
            throw new RuntimeException("Could not delete book", e);
        }
    }
    public OrderDetailDTO getOrderById(Long id) {
    	Order order = orderRepository.findById(id)
    	        .orElseThrow(() -> new RuntimeException("Không tìm thấy đơn hàng với id: " + id));

    	if (order != null) {
    	    List<OrderDetail> orderDetail = orderDetailRepository.getAllByOrder(id);
    	    
    	    // Khởi tạo các danh sách
    	    List<String> bookNames = new ArrayList<>();
    	    List<String> bookImgs = new ArrayList<>();
    	    List<Short> quantity = new ArrayList<>();
    	    List<BigDecimal> price = new ArrayList<>();
    	    
    	    if (orderDetail != null) {
    	        for (int i = 0; i < orderDetail.size(); i++) { // Sử dụng size() để lấy kích thước
    	        	bookImgs.add(orderDetail.get(i).getIsbn().getUrl1());
    	        	bookNames.add(orderDetail.get(i).getIsbn().getTitle()); // Sử dụng get() để truy cập phần tử
    	            quantity.add(orderDetail.get(i).getQuantity()); // Giả sử có phương thức getQuantity()
    	            price.add(orderDetail.get(i).getPrice()); // Giả sử có phương thức getPrice()
    	        }
    	    }
    	
        	 OrderDetailDTO orderDetailDTO = new OrderDetailDTO(
                     order.getOrderId(),
                     order.getUser().getFullName(), // Giả sử có phương thức getUser() trong Order
                     order.getPromotion().getPromotionName(), // Giả sử có phương thức getPromotion() trong Order
                     order.getOrderDate(),
                     order.getReceiver(),
                     order.getAddress(),
                     order.getPaymentMethod(),
                     order.getOrderStatus(),
                     order.getTotalPrice(),
                     bookNames,bookImgs, quantity,price);
        	 return orderDetailDTO;
        }
        return null;
    }


    public Order saveOrder(Order order) {
        return orderRepository.save(order);
    }

    // Phương thức tính doanh thu theo ngày
    public BigDecimal calculateRevenueByDate(LocalDate date) {
        Instant startOfDay = date.atStartOfDay(ZoneId.systemDefault()).toInstant();
        Instant endOfDay = date.atTime(23, 59, 59).atZone(ZoneId.systemDefault()).toInstant();

        return orderRepository.findAll().stream()
                .filter(order ->
                        order.getOrderDate().isAfter(startOfDay) &&
                                order.getOrderDate().isBefore(endOfDay) &&
                                order.getOrderStatus().equals("DELIVERED"))
                .map(Order::getTotalPrice)
                .reduce(BigDecimal.ZERO, BigDecimal::add);
    }

    // Phương thức tính doanh thu theo khoảng thời gian
    public BigDecimal calculateRevenueByDateRange(LocalDate startDate, LocalDate endDate) {
        Instant startInstant = startDate.atStartOfDay(ZoneId.systemDefault()).toInstant();
        Instant endInstant = endDate.atTime(23, 59, 59).atZone(ZoneId.systemDefault()).toInstant();

        return orderRepository.findAll().stream()
                .filter(order ->
                        order.getOrderDate().isAfter(startInstant) &&
                                order.getOrderDate().isBefore(endInstant) &&
                                order.getOrderStatus().equals("DELIVERED"))
                .map(Order::getTotalPrice)
                .reduce(BigDecimal.ZERO, BigDecimal::add);
    }

    // Format tiền tệ
    private String formatCurrency(BigDecimal amount) {
        return String.format("%,.0f ₫", amount.setScale(0, RoundingMode.HALF_UP).doubleValue());
    }
}