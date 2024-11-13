package com.nnthienphuc.intelligentbookstoreecommercewebsite.entity;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.hibernate.annotations.Nationalized;

import java.time.Instant;
import java.time.LocalDateTime;
import java.math.BigDecimal;
import java.util.LinkedHashSet;
import java.util.Set;

@Entity
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class Promotion {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "promotion_id", nullable = false)
    private Integer id;

    @Nationalized
    @Column(name = "promotion_name", nullable = false, length = 100)
    private String promotionName;

    @Column(name = "start_date", nullable = false)
    private Instant startDate;

    @Column(name = "end_date", nullable = false)
    private Instant endDate;

    @Column(name = "condition", nullable = false)
    private BigDecimal condition;

    @Column(name = "discount_percent", nullable = false)
    private Double discountPercent;

    @OneToMany(mappedBy = "promotion")
    private Set<Order> orders = new LinkedHashSet<>();

}