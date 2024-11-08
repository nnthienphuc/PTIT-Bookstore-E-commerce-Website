package com.nnthienphuc.intelligentbookstoreecommercewebsite.model;

import jakarta.persistence.*;
import lombok.*;
@Entity
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Table(name = "OrderDetail")
public class OrderDetail {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;
    // khoa ngoai
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "order_id")
    private Order order;
    private String isbn;
    private Integer quantity;
    private Double price;
}
