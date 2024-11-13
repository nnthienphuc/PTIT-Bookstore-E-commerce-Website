package com.nnthienphuc.intelligentbookstoreecommercewebsite.entity;

import jakarta.persistence.*;
import lombok.*;
import lombok.experimental.FieldDefaults;
import org.hibernate.annotations.Nationalized;

import java.time.Instant;
import java.util.Date;
import java.util.LinkedHashSet;
import java.util.Set;

@Entity
@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE)
public class User {
    @Id
    @Column(name = "user_id", nullable = false, length = 50)
    private String userId;

    @Column(name = "email", nullable = false, length = 50)
    private String email;

    @Nationalized
    @Column(name = "full_name", nullable = false, length = 60)
    private String fullName;

    @Column(name = "gender", nullable = false)
    private Boolean gender = false;

    @Column(name = "birthday", nullable = false)
    private Instant birthday;

    @Column(name = "pwd", nullable = false, length = 60)
    private String pwd;

    @OneToMany(mappedBy = "user")
    private Set<Order> orders = new LinkedHashSet<>();

    @Column(name = "is_active", nullable = false)
    private Boolean isActive = false;
}
