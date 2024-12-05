package com.nnthienphuc.intelligentbookstoreecommercewebsite.interceptor;

import com.nnthienphuc.intelligentbookstoreecommercewebsite.entity.Author;
import com.nnthienphuc.intelligentbookstoreecommercewebsite.entity.Book;
import com.nnthienphuc.intelligentbookstoreecommercewebsite.entity.Category;
import com.nnthienphuc.intelligentbookstoreecommercewebsite.entity.Publisher;
import com.nnthienphuc.intelligentbookstoreecommercewebsite.service.AuthorService;
import com.nnthienphuc.intelligentbookstoreecommercewebsite.service.BookService;
import com.nnthienphuc.intelligentbookstoreecommercewebsite.service.CategoryService;
import com.nnthienphuc.intelligentbookstoreecommercewebsite.service.PublisherService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;

public class BookStoreInterceptor implements HandlerInterceptor {
    @Autowired
    CategoryService categoryService;

    @Autowired
    BookService bookService;

    @Autowired
    AuthorService authorService;

    @Autowired
    PublisherService publisherService;

    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
                           ModelAndView modelAndView) throws Exception {
        List<Category> categories = categoryService.getAllCategories();
        request.setAttribute("cates", categories);

        List<Book> books = bookService.getAllBooks();
        request.setAttribute("books", books);

        List<Author> authors = authorService.getAllAuthors();
        request.setAttribute("authors", authors);

        List<Publisher> publishers = publisherService.getAllPublishers();
        request.setAttribute("publishers", publishers);
    }
}
