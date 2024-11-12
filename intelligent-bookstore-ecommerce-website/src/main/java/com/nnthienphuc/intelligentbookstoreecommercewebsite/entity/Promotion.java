package com.nnthienphuc.intelligentbookstoreecommercewebsite.entity;
import jakarta.persistence.*;
import lombok.Data;
import java.time.LocalDateTime;
import java.math.BigDecimal;

@Entity
@Table(name = "Promotion")
@Data
public class Promotion {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "PromotioniD")
    private Short promotionId;
    
    @Column(name = "Promotionname", nullable = false, length = 100)
    private String promotionName;
    
    @Column(name = "Startdate", nullable = false)
    private LocalDateTime startDate;
    
    @Column(name = "Enddate", nullable = false)
    private LocalDateTime endDate;
    
    @Column(name = "Condition", nullable = false)
    private BigDecimal condition;
    
    @Column(name = "Discountpercent", nullable = false)
    private Double discountPercent;
}