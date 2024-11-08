package com.nnthienphuc.intelligentbookstoreecommercewebsite.model;

import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.*;
import lombok.*;
import lombok.experimental.FieldDefaults;

import java.util.*;

@Entity
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Table(name = "promotion")
public class Promotion {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;
    private String promotionName;
    private Date startDate;
    private Date endDate;
    private Double promotionCondition;
    private Double discountPercent;

    @OneToMany(mappedBy = "promotion", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    @JsonIgnore
    private List<Order> orders;

}
