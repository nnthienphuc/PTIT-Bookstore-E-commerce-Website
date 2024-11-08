package com.nnthienphuc.intelligentbookstoreecommercewebsite.entity;

import jakarta.persistence.*;
import lombok.*;
import lombok.experimental.FieldDefaults;

import java.util.Date;
import java.util.LinkedHashSet;
import java.util.Set;

@Entity
@Data
@AllArgsConstructor
@NoArgsConstructor
@ToString
@Table(name = "Promotion")
@FieldDefaults(level = AccessLevel.PRIVATE)
public class Promotion {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    int promotionID;
    String promotionName;
    Date startDate;
    Date endDate;
    long condition;
    float discountPercent;

    @OneToMany(mappedBy = "promotionID")
    private Set<Order> orders = new LinkedHashSet<>();

}
