package com.nnthienphuc.intelligentbookstoreecommercewebsite.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;

@Entity
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class SatisfyProduct implements Serializable {
    private static final long serialVersionUID = 1L;

    @EmbeddedId
    private SatisfyProductId id;

    @MapsId
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "history_id", nullable = false)
    private History history;

    @MapsId
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "isbn", nullable = false)
    private Book isbn;

    public Book getIsbn() {
        return isbn;
    }

    public void setIsbn(Book isbn) {
        this.isbn = isbn;
    }

    public History getHistory() {
        return history;
    }

    public void setHistory(History history) {
        this.history = history;
    }

    public SatisfyProductId getId() {
        return id;
    }

    public void setId(SatisfyProductId id) {
        this.id = id;
    }
}
