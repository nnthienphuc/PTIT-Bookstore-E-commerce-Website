package com.nnthienphuc.intelligentbookstoreecommercewebsite.entity;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import lombok.*;
import lombok.experimental.FieldDefaults;

import java.util.Date;

@Entity
@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE)
public class Staff {
    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    String staffID;
    String fullName;
    String email;
    String phone;
    String idCard;
    boolean roleID;
    boolean gender;
    Date birthday;
    String address;
    String pwd;
    boolean isQuit;
}
