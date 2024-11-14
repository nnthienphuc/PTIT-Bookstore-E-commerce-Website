package com.nnthienphuc.intelligentbookstoreecommercewebsite.entity;

import jakarta.persistence.*;
import lombok.*;
import lombok.experimental.FieldDefaults;
import org.hibernate.annotations.ColumnDefault;
import org.hibernate.annotations.Nationalized;

import java.math.BigDecimal;
import java.util.LinkedHashSet;
import java.util.Set;

@Entity
@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class Book {
    @Id
    @Column(name = "isbn", nullable = false, length = 13)
    private String isbn;

    @Nationalized
    @Column(name = "title", nullable = false, length = 200)
    private String title;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "category_id", nullable = false)
    private Category category_id;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "author_id", nullable = false)
    private Author author_id;

    @Column(name = "year_of_publication", nullable = false)
    private Short year_of_publication;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "publisher_id", nullable = false)
    private Publisher publisher_id;

    @Column(name = "quantity", nullable = false)
    private Integer quantity;

    @ColumnDefault("0")
    @Column(name = "cover", nullable = false)
    private Boolean cover = false;

    @Column(name = "price", nullable = false)
    private BigDecimal price;

    @ColumnDefault("0.0")
    @Column(name = "discount_percent", nullable = false)
    private Double discount_percent;

    @ColumnDefault("0")
    @Column(name = "is_discount", nullable = false)
    private Boolean is_discount = false;

    @Nationalized
    @Lob
    @Column(name = "description", nullable = false)
    private String description;

    @Column(name = "url1", nullable = false)
    private String url1;

    @Column(name = "url2", nullable = false)
    private String url2;

    @Column(name = "url3", nullable = false)
    private String url3;

    @Column(name = "url4", nullable = false)
    private String url4;

    @Column(name = "url5", nullable = false)
    private String url5;

    @ColumnDefault("0")
    @Column(name = "is_discontinued", nullable = false)
    private Boolean is_discontinued = false;

    @OneToMany(mappedBy = "isbn")
    private Set<OrderDetail> orderDetails = new LinkedHashSet<>();

}
