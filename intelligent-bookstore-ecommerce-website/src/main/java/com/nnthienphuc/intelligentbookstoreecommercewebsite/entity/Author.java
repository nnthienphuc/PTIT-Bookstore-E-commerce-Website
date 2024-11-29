package com.nnthienphuc.intelligentbookstoreecommercewebsite.entity;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import jakarta.persistence.*;
import lombok.Data;

@Entity
@Table(name = "Author")
@Data
@JsonIgnoreProperties({"hibernateLazyInitializer", "handler"})
@Builder
@NoArgsConstructor
@AllArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE)

public class Author {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "author_id", nullable = false)
    private Short id;

    @Nationalized
    @Column(name = "author_name", nullable = false, length = 50)
    private String authorName;

    @OneToMany(mappedBy = "author_id")
    private Set<Book> books = new LinkedHashSet<>();

    public String getAuthorName() {
        return authorName;
    }

    public void setAuthorName(String authorName) {
        this.authorName = authorName;
    }
}