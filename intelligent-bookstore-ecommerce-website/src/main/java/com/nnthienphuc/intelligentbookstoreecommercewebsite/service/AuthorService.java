package com.nnthienphuc.intelligentbookstoreecommercewebsite.service;

import java.util.List;

import com.nnthienphuc.intelligentbookstoreecommercewebsite.repository.AuthorRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.nnthienphuc.intelligentbookstoreecommercewebsite.entity.Author;
import com.nnthienphuc.intelligentbookstoreecommercewebsite.repository.AuthorRepository;

@Service
public class AuthorService {

    @Autowired
    private AuthorRepository AuthorRepository;


    public List<Author> getAllAuthors() {
        return AuthorRepository.findAll();
    }


    public Author getAuthorById(Long id) {
        return AuthorRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Không tìm thấy danh mục với id: " + id));
    }


    public Author saveAuthor(Author Author) {
        return AuthorRepository.save(Author);
    }


    public void deleteAuthor(Long id) {
        AuthorRepository.deleteById(id);
    }
    public List<Author> searchByKeyword(String keyword) {
        if (keyword == null || keyword.trim().isEmpty()) {
            return AuthorRepository.findAll(); // Trả về tất cả nếu keyword trống
        }
        return AuthorRepository.findByAuthorNameContainingIgnoreCase(keyword.trim());
    }
}