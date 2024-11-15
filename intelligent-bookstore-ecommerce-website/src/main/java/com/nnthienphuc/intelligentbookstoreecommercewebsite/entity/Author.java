package com.nnthienphuc.intelligentbookstoreecommercewebsite.entity;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import jakarta.persistence.*;
import lombok.Data;

@Entity
@Table(name = "Author")
@Data
@JsonIgnoreProperties({"hibernateLazyInitializer", "handler"})
public class Author {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "Author_ID")
    private Short authorId;
    
    @Column(name = "Author_Name", nullable = false, length = 50)
    private String authorName;

    public Author() {}
    public Short getAuthorId() {
        return authorId;
    }

    public void setAuthorId(Short authorId) {
        this.authorId = authorId;
    }

    public String getAuthorName() {
        return authorName;
    }

    public void setAuthorName(String authorName) {
        this.authorName = authorName;
    }
}