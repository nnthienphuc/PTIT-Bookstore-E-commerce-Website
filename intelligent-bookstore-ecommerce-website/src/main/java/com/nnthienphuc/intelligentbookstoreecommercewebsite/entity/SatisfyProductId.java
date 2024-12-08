package com.nnthienphuc.intelligentbookstoreecommercewebsite.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Embeddable;
import lombok.Getter;
import lombok.Setter;
import org.hibernate.Hibernate;

import java.util.Objects;

@Getter
@Setter
@Embeddable
public class SatisfyProductId implements java.io.Serializable {
    private static final long serialVersionUID = -6338524666298575263L;
    @Column(name = "history_id", nullable = false)
    private Integer historyId;

    @Column(name = "isbn", nullable = false, length = 13)
    private String isbn;

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || Hibernate.getClass(this) != Hibernate.getClass(o)) return false;
        SatisfyProductId entity = (SatisfyProductId) o;
        return Objects.equals(this.historyId, entity.historyId) &&
                Objects.equals(this.isbn, entity.isbn);
    }

    @Override
    public int hashCode() {
        return Objects.hash(historyId, isbn);
    }

}