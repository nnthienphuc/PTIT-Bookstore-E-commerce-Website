package com.nnthienphuc.intelligentbookstoreecommercewebsite.repository;

import com.nnthienphuc.intelligentbookstoreecommercewebsite.entity.Author;
import com.nnthienphuc.intelligentbookstoreecommercewebsite.entity.User;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.expression.spel.ast.OpAnd;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface UserRepository extends JpaRepository<User, String> {
    User findByEmail(String email);

    Page<User> findByFullNameContainingIgnoreCase(String keyword, Pageable pageable);

    @Query("SELECT u from User u where u.userId = :userId")
    Optional<User> findByUserId(@Param("userId") String userId);

//    @Query("SELECT u FROM User u WHERE LOWER(u.fullName) LIKE LOWER(CONCAT('%', :fullName, '%'))")
//    List<User> findByFullNameContainingIgnoreCase(@Param("fullName") String fullName);
//
//    // Tìm kiếm người dùng theo tên hoặc email (có phân trang)
//    Page<User> findByFullNameContainingIgnoreCaseOrEmailContainingIgnoreCase(
//            String fullName, String email, Pageable pageable);
}
