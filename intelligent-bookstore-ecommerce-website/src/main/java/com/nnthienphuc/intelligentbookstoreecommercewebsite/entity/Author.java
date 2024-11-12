package com.nnthienphuc.intelligentbookstoreecommercewebsite.entity;
import jakarta.persistence.*;
import lombok.Data;

@Entity
@Table(name = "Author")
@Data
public class Author {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "AuthoriD")
    private Short authorId;
    
    @Column(name = "Authorname", nullable = false, length = 50)
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