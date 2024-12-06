package com.nnthienphuc.intelligentbookstoreecommercewebsite.service;

import com.nnthienphuc.intelligentbookstoreecommercewebsite.entity.Author;
import com.nnthienphuc.intelligentbookstoreecommercewebsite.entity.Staff;
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

        PasswordEncoder passwordEncoder = new BCryptPasswordEncoder(10);
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
        // Mã hóa mật khẩu trước khi lưu vào database
        user.setPwd(passwordEncoder.encode(user.getPwd()));
        return userRepository.save(user);
    }

    public boolean checkPassword(String rawPassword, String encodedPassword) {
        return passwordEncoder.matches(rawPassword, encodedPassword);
    }

    // Thêm phương thức tìm kiếm người dùng theo fullName hoặc một phần tên
    public List<User> findByFullNameContainingIgnoreCase(String fullName) {
        return userRepository.findByFullNameContainingIgnoreCase(fullName);
    }
    
    public Page<User> searchUsers(String keyword, Pageable pageable) {
        try {
        	return userRepository.findByFullNameContainingIgnoreCase(keyword,pageable);
        } catch (Exception e) {
            throw new RuntimeException("Error searching staff", e);
        }
    }
    public Page<User> getAllUsersPagging(Pageable pageable) {
        return userRepository.findAll(pageable);
    }


    public User getUserById(String id) {
        return userRepository.findByUserId(id)
                .orElseThrow(() -> new RuntimeException("Không tìm thấy nhân viên với id: " + id));
    }


    public User saveUser(User user) {
        return userRepository.save(user);
    }


    public void deleteUser(String id) {
    	userRepository.deleteById(id);
    }
}
