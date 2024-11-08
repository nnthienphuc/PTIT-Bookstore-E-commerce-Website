package com.nnthienphuc.intelligentbookstoreecommercewebsite.model;

import jakarta.persistence.*;
import lombok.*;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Entity
public class Book {
    @Id
    @GeneratedValue(strategy = jakarta.persistence.GenerationType.IDENTITY)
    private Integer id;
    private String isbn;
    private String title;
    // khoa ngoai
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "CATEGORY_ID")
    private Category category;
    // khoa ngoai
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "AUTHOR_ID")
    private Author author;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "PUBLISHER_ID")
    private Publisher publisher;

    private Integer yearOfPublication;
    private Integer quantity;
    private Boolean cover; // bia cung & bia mem
    private double price;
    private Integer discountPercent;
    private boolean isDiscount;
    private String description;
    private String urlImage;
    private boolean isDiscontinued;
}
