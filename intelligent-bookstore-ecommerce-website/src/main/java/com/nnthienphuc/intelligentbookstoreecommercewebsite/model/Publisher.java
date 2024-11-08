package com.nnthienphuc.intelligentbookstoreecommercewebsite.model;

import jakarta.persistence.*;
import lombok.*;

import java.util.List;

@Entity
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class Publisher {
    @Id @GeneratedValue(strategy = jakarta.persistence.GenerationType.IDENTITY)
    private Integer id;
    private String publisherName;

    // lien ket
     @OneToMany(mappedBy = "publisher", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
     private List<Book> books;
}
