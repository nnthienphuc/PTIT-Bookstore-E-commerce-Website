package com.nnthienphuc.intelligentbookstoreecommercewebsite.model;

import jakarta.persistence.*;
import lombok.*;
import lombok.experimental.FieldDefaults;

import java.util.Date;

@Entity
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Table(name = "Staff")
public class Staff {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;
    private String fullName;
    private String email;
    private String phone;
    private String idCard;
    private boolean gender;
    private Date birthday;
    private String address;
    private String pwd;
    private boolean isQuit;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "role_id", referencedColumnName = "id")
    private Role role;
}
