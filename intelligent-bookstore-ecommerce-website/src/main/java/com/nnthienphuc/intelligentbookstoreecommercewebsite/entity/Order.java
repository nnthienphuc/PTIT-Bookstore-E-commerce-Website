package com.nnthienphuc.intelligentbookstoreecommercewebsite.entity;

import jakarta.persistence.*;
import lombok.*;
import lombok.experimental.FieldDefaults;

import java.util.Date;

@Entity
@Data
@AllArgsConstructor
@NoArgsConstructor
@ToString
@Table(name = "Order")
@FieldDefaults(level = AccessLevel.PRIVATE)
public class Order {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    long orderID;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "PromotionID")
    Promotion promotionID;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "UserID")
    User userID;

    Date orderDate;
    String receiver;
    String address;
    String paymentMethod;
    String orderStatus;
    long totalPrice;
}
