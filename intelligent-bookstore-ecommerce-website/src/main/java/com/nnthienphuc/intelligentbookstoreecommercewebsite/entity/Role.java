package com.nnthienphuc.intelligentbookstoreecommercewebsite.entity;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;
import lombok.*;
import lombok.experimental.FieldDefaults;

import java.util.LinkedHashSet;
import java.util.Set;

@Entity
@Data
@AllArgsConstructor
@NoArgsConstructor
@ToString
@Table(name = "Role")
@FieldDefaults(level = AccessLevel.PRIVATE)
public class Role {
    @Id
    String roleID;
    String roleName;

    @OneToMany(mappedBy = "roleID")
    Set<Staff> staff = new LinkedHashSet<>();
}
