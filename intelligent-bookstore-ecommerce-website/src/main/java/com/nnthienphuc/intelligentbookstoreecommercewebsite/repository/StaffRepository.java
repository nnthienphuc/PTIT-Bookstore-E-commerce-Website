package com.nnthienphuc.intelligentbookstoreecommercewebsite.repository;

import com.nnthienphuc.intelligentbookstoreecommercewebsite.entity.Staff;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface StaffRepository extends JpaRepository<Staff, String> {
    Staff findByEmail(String email);

    @Query("SELECT s FROM User s WHERE LOWER(s.fullName) LIKE LOWER(CONCAT('%', :fullName, '%'))")
    List<Staff> findByFullNameContainingIgnoreCase(@Param("fullName") String fullName);
}
