package com.nnthienphuc.intelligentbookstoreecommercewebsite.model;

import jakarta.persistence.*;
import lombok.*;
import lombok.experimental.FieldDefaults;

import java.util.Date;
import java.util.LinkedHashSet;
import java.util.Set;

@Entity
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Table(name = "User")
public class User {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;
    private String email;
    private String fullName;
    private boolean gender;
    private Date birthDay;
    private String pwd;

    @OneToMany(mappedBy = "user", cascade = CascadeType.ALL, orphanRemoval = true)
    Set<Order> orders = new LinkedHashSet<>();

}
