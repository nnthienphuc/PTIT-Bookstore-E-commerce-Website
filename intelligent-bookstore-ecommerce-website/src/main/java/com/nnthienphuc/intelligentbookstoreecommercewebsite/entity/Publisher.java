package com.nnthienphuc.intelligentbookstoreecommercewebsite.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.hibernate.annotations.Nationalized;

import java.util.LinkedHashSet;
import java.util.Set;

@Entity
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class Publisher {

    @Id
    @Column(name = "publisher_id", nullable = false)
    private Short id;

    @Nationalized
    @Column(name = "publisher_name", nullable = false, length = 50)
    private String publisherName;

    @OneToMany(mappedBy = "publisher_id")
    private Set<Book> books = new LinkedHashSet<>();

}