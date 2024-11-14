package com.nnthienphuc.intelligentbookstoreecommercewebsite.service;

import com.nnthienphuc.intelligentbookstoreecommercewebsite.entity.Role;
import com.nnthienphuc.intelligentbookstoreecommercewebsite.entity.Staff;
import com.nnthienphuc.intelligentbookstoreecommercewebsite.repository.StaffRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class StaffService {
    @Autowired
    private StaffRepository staffRepository;

    @Autowired
    private PasswordEncoder passwordEncoder;
    @Autowired
    private RoleService roleService;

    public Optional<Staff> findById(String staffId) {
        return staffRepository.findById(staffId);
    }

    public Staff findByEmail(String email) {
        return staffRepository.findByEmail(email);
    }

    public List<Staff> findAll() {
        return staffRepository.findAll();
    }

    public Staff create(Staff staff) throws Exception {
        if(staffRepository.existsById(staff.getStaffId())) {
            throw new Exception("Username has exist!");
        }

        Role role = roleService.findRoleByName("staff");

        staff.setRole(role);
        PasswordEncoder passwordEncoder = new BCryptPasswordEncoder(10);
        staff.setPwd(passwordEncoder.encode(staff.getPwd()));

        return staffRepository.save(staff);
    }

    public Staff update(Staff staff) {
        return staffRepository.save(staff);
    }

    public void delete(String staffId) {
        staffRepository.deleteById(staffId);
    }

    public Staff registerStaff(Staff staff) {
        // Mã hóa mật khẩu trước khi lưu vào database
        staff.setPwd(passwordEncoder.encode(staff.getPwd()));
        return staffRepository.save(staff);
    }

    public boolean checkPassword(String rawPassword, String encodedPassword) {
        return passwordEncoder.matches(rawPassword, encodedPassword);
    }

    // Thêm phương thức tìm kiếm người dùng theo fullName hoặc một phần tên
    public List<Staff> findByFullNameContainingIgnoreCase(String fullName) {
        return staffRepository.findByFullNameContainingIgnoreCase(fullName);
    }
}
