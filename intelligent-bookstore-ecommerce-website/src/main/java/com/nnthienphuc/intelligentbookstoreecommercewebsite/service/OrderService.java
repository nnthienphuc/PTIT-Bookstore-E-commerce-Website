package com.nnthienphuc.intelligentbookstoreecommercewebsite.service;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.time.Instant;
import java.time.LocalDate;
import java.time.ZoneId;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.stream.Collectors;

import com.nnthienphuc.intelligentbookstoreecommercewebsite.entity.*;
import com.nnthienphuc.intelligentbookstoreecommercewebsite.repository.*;
import com.nnthienphuc.intelligentbookstoreecommercewebsite.DTO.RevenueDetailsDTO;

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
import com.nnthienphuc.intelligentbookstoreecommercewebsite.model.OrderStatus;
import com.nnthienphuc.intelligentbookstoreecommercewebsite.repository.OrderRepository;

@Service
@Transactional
public class OrderService {
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

    public void processCheckout(String userId) {
        // Lấy tất cả sản phẩm trong giỏ hàng của user
        List<Cart> cartItems = cartRepository.findByCustomerId(userId);
        if (cartItems.isEmpty()) {
            throw new RuntimeException("Giỏ hàng trống. Không thể thanh toán.");
        }

        // Tính tổng giá trị đơn hàng
        BigDecimal totalPrice = cartItems.stream()
                .map(item -> {
                    BigDecimal priceAfterDiscount = item.getIsbn().getPrice()
                            .multiply(BigDecimal.valueOf(item.getQuantity()))
                            .multiply(BigDecimal.ONE.subtract(BigDecimal.valueOf(item.getIsbn().getDiscount_percent()))); // Giảm giá
                    return priceAfterDiscount;
                })
                .reduce(BigDecimal.ZERO, BigDecimal::add);

        totalPrice = totalPrice.add(BigDecimal.valueOf(30000));        // Tạo đơn hàng mới
        Order order = new Order();
        order.setUser(userService.getUserById(userId));
        order.setTotalPrice(totalPrice);
        order.setOrderDate(LocalDateTime.now().atZone(ZoneId.systemDefault()).toInstant());
        order.setOrderStatus("PENDING");
        order.setAddress(userService.getUserById(userId).getAddress());
        order.setPaymentMethod("Cash");
        order.setReceiver(userService.getUserById(userId).getFullName());
        order.setPromotion(promotionService.getPromotionById(8L));

        order = orderRepository.save(order);

        // Tạo chi tiết đơn hàng và cập nhật số lượng sách
        for (Cart cartItem : cartItems) {
            // Tạo OrderDetail
            OrderDetail orderDetail = new OrderDetail();
            orderDetail.setOrder(order);
            orderDetail.setIsbn(cartItem.getIsbn());
            orderDetail.setQuantity(cartItem.getQuantity());
            BigDecimal price = cartItem.getIsbn().getPrice();
            BigDecimal discountPercent = BigDecimal.valueOf(cartItem.getIsbn().getDiscount_percent());

            // Tính toán giá sau khi giảm giá
            BigDecimal discountedPrice = price.multiply(BigDecimal.ONE.subtract(discountPercent));

// Gán giá trị đã tính toán
            orderDetail.setPrice(discountedPrice);

//            orderDetail.setPrice(cartItem.getIsbn().getPrice()*(1-cartItem.getIsbn().getDiscount_percent()));
            orderDetailRepository.save(orderDetail);

            // Giảm số lượng sách
            Book book = cartItem.getIsbn();
            int remainingQuantity = book.getQuantity() - cartItem.getQuantity();
            if (remainingQuantity < 0) {
                throw new RuntimeException("Số lượng sách không đủ: " + book.getTitle());
            }
            book.setQuantity(remainingQuantity);
            bookRepository.save(book);
        }

        // Xóa giỏ hàng của user
        cartRepository.deleteByUserId(userId);
    }

    public List<Order> findByUserId(String userId) {
        return orderRepository.findByUserId(userId);
    }
}