package com.nnthienphuc.intelligentbookstoreecommercewebsite.service;

import com.nnthienphuc.intelligentbookstoreecommercewebsite.entity.Author;
import com.nnthienphuc.intelligentbookstoreecommercewebsite.entity.User;
import com.nnthienphuc.intelligentbookstoreecommercewebsite.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class UserService {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private PasswordEncoder passwordEncoder;

    // Phương thức để lấy danh sách user có phân trang
    public Page<User> getAllUsers(Pageable pageable) {
        return userRepository.findAll(pageable);
    }

    // Phương thức tìm kiếm user có phân trang
    public Page<User> searchUsers(String keyword, Pageable pageable) {
        return userRepository.findByFullNameContainingIgnoreCase(keyword, pageable);
    }

    // Lấy user theo ID
    public User getUserById(String id) {
        return userRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Không tìm thấy người dùng với ID: " + id));
    }

    // Lưu hoặc cập nhật user
    public User saveUser(User user) {
        // Nếu là user mới hoặc đang thay đổi mật khẩu
        if (user.getPwd() != null && !user.getPwd().isEmpty()) {
            user.setPwd(passwordEncoder.encode(user.getPwd()));
        } else {
            // Nếu không thay đổi mật khẩu, lấy mật khẩu cũ
            Optional<User> existingUser = userRepository.findById(user.getUserId());
            existingUser.ifPresent(u -> user.setPwd(u.getPwd()));
        }

        return userRepository.save(user);
    }

    // Xóa user
    public void deleteUser(String userId) {
        userRepository.deleteById(userId);
    }

    // Các phương thức còn lại từ service cũ
    public Optional<User> findById(String userId) {
        return userRepository.findById(userId);
    }

    public User findByEmail(String email) {
        return userRepository.findByEmail(email);
    }

    public List<User> findAll() {
        return userRepository.findAll();
    }

    public User create(User user) throws Exception {
        if(userRepository.existsById(user.getUserId())) {
            throw new Exception("Username has exist!");
        }

        user.setPwd(passwordEncoder.encode(user.getPwd()));
        return userRepository.save(user);
    }

    public User update(User user) {
        return userRepository.save(user);
    }

    public void delete(String userId) {
        userRepository.deleteById(userId);
    }

    public User registerUser(User user) {
        user.setPwd(passwordEncoder.encode(user.getPwd()));
        return userRepository.save(user);
    }

    public boolean checkPassword(String rawPassword, String encodedPassword) {
        return passwordEncoder.matches(rawPassword, encodedPassword);
    }

//    public List<User> findByFullNameContainingIgnoreCase(String fullName) {
//        return userRepository.findByFullNameContainingIgnoreCase(fullName);
//    }
}