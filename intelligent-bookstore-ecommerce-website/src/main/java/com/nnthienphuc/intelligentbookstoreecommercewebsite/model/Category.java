package com.nnthienphuc.intelligentbookstoreecommercewebsite.model;

import jakarta.persistence.*;
import lombok.*;

import java.util.List;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Entity
public class Category {
    @Id @GeneratedValue(strategy = jakarta.persistence.GenerationType.IDENTITY)
    private Integer id;
    private String categoryName;
    // lien ket
    @OneToMany(mappedBy = "category", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private List<Book> books;
}
