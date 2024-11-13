package com.nnthienphuc.intelligentbookstoreecommercewebsite.entity;

import jakarta.persistence.*;
import lombok.*;
import lombok.experimental.FieldDefaults;
import org.hibernate.annotations.ColumnDefault;
import org.hibernate.annotations.Nationalized;

import java.time.Instant;
import java.util.Date;

@Entity
@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE)
public class Staff {

    @Id
    @Column(name = "staff_id", nullable = false, length = 36)
    private String staffId;

    @Nationalized
    @Column(name = "full_name", nullable = false, length = 60)
    private String fullName;

    @Column(name = "email", nullable = false, length = 50)
    private String email;

    @Column(name = "phome", nullable = false, length = 10)
    private String phome;

    @Column(name = "id_card", nullable = false, length = 12)
    private String idCard;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @ColumnDefault("0")
    @JoinColumn(name = "role_id", nullable = false)
    private Role role;

    @ColumnDefault("0")
    @Column(name = "gender", nullable = false)
    private Boolean gender = false;

    @Column(name = "birthday", nullable = false)
    private Instant birthday;

    @Nationalized
    @Column(name = "address", nullable = false, length = 100)
    private String address;

    @Column(name = "pwd", nullable = false, length = 60)
    private String pwd;

    @ColumnDefault("0")
    @Column(name = "is_quit", nullable = false)
    private Boolean isQuit = false;

    @Column(name = "is_active", nullable = false)
    private Boolean isActive = false;

}
