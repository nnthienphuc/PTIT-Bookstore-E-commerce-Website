package com.nnthienphuc.intelligentbookstoreecommercewebsite.entity;

import jakarta.persistence.*;
import lombok.*;
import lombok.experimental.FieldDefaults;
import org.hibernate.annotations.ColumnDefault;
import org.hibernate.annotations.Nationalized;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import java.math.BigDecimal;
import java.util.LinkedHashSet;
import java.util.Set;

import javax.validation.constraints.Max;
import javax.validation.constraints.Min;

@Entity

@Builder
@AllArgsConstructor
@NoArgsConstructor
//@ToString
@Table(name = "Book")
@JsonIgnoreProperties({"hibernateLazyInitializer", "handler"})
@FieldDefaults(level = AccessLevel.PRIVATE)
public class Book {
    @Id
    @Column(name = "isbn", nullable = false, length = 13)
    private String isbn;

    @Nationalized
    @Column(name = "title", nullable = false, length = 200)
    private String title;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "category_id", nullable = false)
    private Category categoryId;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "author_id", nullable = false)
    private Author authorId;

    @Column(name = "year_of_publication", nullable = false)
    @Min(value = 1900, message = "Năm xuất bản không được nhỏ hơn 1900")
    @Max(value = 2024, message = "Năm xuất bản không được lớn hơn năm hiện tại")
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

 // Getters
    public String getIsbn() {
        return isbn;
    }

    public String getTitle() {
        return title;
    }

    public Category getCategoryId() {
        return categoryId;
    }

    public Author getAuthorId() {
        return authorId;
    }

    public Short getYear_of_publication() {
        return year_of_publication;
    }

    public Publisher getPublisher_id() {
        return publisher_id;
    }

    public Integer getQuantity() {
        return quantity;
    }

    public Boolean getCover() {
        return cover;
    }

    public BigDecimal getPrice() {
        return price;
    }

    public Double getDiscount_percent() {
        return discount_percent;
    }

    public Boolean getIs_discount() {
        return is_discount;
    }

    public String getDescription() {
        return description;
    }

    public String getUrl1() {
        return url1;
    }

    public String getUrl2() {
        return url2;
    }

    public String getUrl3() {
        return url3;
    }

    public String getUrl4() {
        return url4;
    }

    public String getUrl5() {
        return url5;
    }

    public Boolean getIs_discontinued() {
        return is_discontinued;
    }

    // Setters
    public void setIsbn(String isbn) {
        this.isbn = isbn;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public void setCategoryId(Category categoryId) {
        this.categoryId = categoryId;
    }

    public void setAuthorId(Author authorId) {
        this.authorId = authorId;
    }

    public void setYear_of_publication(Short year_of_publication) {
        this.year_of_publication = year_of_publication;
    }

    public void setPublisher_id(Publisher publisher_id) {
        this.publisher_id = publisher_id;
    }

    public void setQuantity(Integer quantity) {
        this.quantity = quantity;
    }

    public void setCover(Boolean cover) {
        this.cover = cover;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }

    public void setDiscount_percent(Double discount_percent) {
        this.discount_percent = discount_percent;
    }

    public void setIs_discount(Boolean is_discount) {
        this.is_discount = is_discount;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public void setUrl1(String url1) {
        this.url1 = url1;
    }

    public void setUrl2(String url2) {
        this.url2 = url2;
    }

    public void setUrl3(String url3) {
        this.url3 = url3;
    }

    public void setUrl4(String url4) {
        this.url4 = url4;
    }

    public void setUrl5(String url5) {
        this.url5 = url5;
    }

    public void setIs_discontinued(Boolean is_discontinued) {
        this.is_discontinued = is_discontinued;
    }
}
