package com.nnthienphuc.intelligentbookstoreecommercewebsite.entity;

import jakarta.persistence.*;
import lombok.Data;

@Entity
@Table(name = "Publisher")
@Data
public class Publisher {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "PublisheriD")
    private Short publisherId;
    
    @Column(name = "Publishername", nullable = false, length = 50)
    private String publisherName;
    
    public Publisher() {}
    public Short getPublisherId() {
        return publisherId;
    }

    public void setPublisherId(Short publisherId) {
        this.publisherId = publisherId;
    }

    public String getPublisherName() {
        return publisherName;
    }

    public void setPublisherName(String publisherName) {
        this.publisherName = publisherName;
    }
}