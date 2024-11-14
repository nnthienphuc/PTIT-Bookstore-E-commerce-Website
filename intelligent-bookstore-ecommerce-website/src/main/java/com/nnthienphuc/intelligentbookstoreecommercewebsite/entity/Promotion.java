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
    @Column(name = "Promotion_ID")
    private Short promotionId;
    
    @Column(name = "Promotion_Name", nullable = false, length = 100)
    private String promotionName;
    
    @Column(name = "Start_Date", nullable = false)
    private LocalDateTime startDate;
    
    @Column(name = "End_Date", nullable = false)
    private LocalDateTime endDate;
    
    @Column(name = "Condition", nullable = false)
    private BigDecimal condition;
    
    @Column(name = "Discount_Percent", nullable = false)
    private Double discountPercent;
}