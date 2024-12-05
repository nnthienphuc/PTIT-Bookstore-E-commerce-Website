package com.nnthienphuc.intelligentbookstoreecommercewebsite.controller.admin;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.nnthienphuc.intelligentbookstoreecommercewebsite.entity.Book;
import com.nnthienphuc.intelligentbookstoreecommercewebsite.service.AuthorService;
import com.nnthienphuc.intelligentbookstoreecommercewebsite.service.BookService;
import com.nnthienphuc.intelligentbookstoreecommercewebsite.service.CategoryService;
import com.nnthienphuc.intelligentbookstoreecommercewebsite.service.PublisherService;

@Controller
@RequestMapping("/admin/book")
public class BookController {

    @Autowired
    private BookService bookService;
    
    @Autowired
    private CategoryService categoryService;
    
    @Autowired
    private AuthorService authorService;
    
    @Autowired
    private PublisherService publisherService;
    
    @Value("${upload.path}")
    private String uploadPath;

    @GetMapping("")
    public String showBooks(
            @RequestParam(required = false) String keyword,
            @RequestParam(required = false) Long categoryId,
            @RequestParam(required = false) Long authorId,
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "10") int size,
            Model model) {
        try {
            Page<Book> books = bookService.searchBooks(keyword, categoryId, authorId, 
                PageRequest.of(page, size, Sort.by("title").ascending()));
            
            model.addAttribute("books", books);
            model.addAttribute("categories", categoryService.getAllCategoriesNoPaging());
            model.addAttribute("authors", authorService.getAllAuthorsNoPaging());
            model.addAttribute("publishers", publisherService.getAllPublishersNoPaging());
            
            return "admin/book";
        } catch (Exception e) {
            e.printStackTrace();
            return "error";
        }
    }

    @PostMapping("/add")
    public String addBook(@ModelAttribute Book book,
                         @RequestParam("images") MultipartFile[] images,
                         RedirectAttributes redirectAttributes) {
        try {
            bookService.saveBook(book, images);
            redirectAttributes.addAttribute("success", "add");
            return "redirect:/admin/book";
        } catch (Exception e) {
            e.printStackTrace();
            redirectAttributes.addAttribute("error", "add");
            return "redirect:/admin/book";
        }
    }

    @GetMapping("/{isbn}")
    @ResponseBody
    public ResponseEntity<Book> getBook(@PathVariable String isbn) {
        try {
            Book book = bookService.getBookByIsbn(isbn);
            return ResponseEntity.ok(book);
        } catch (Exception e) {
            return ResponseEntity.notFound().build();
        }
    }

    @PostMapping("/edit")
    public String editBook(@RequestParam String isbn,
                          @ModelAttribute Book bookDetails,
                          @RequestParam(value = "images", required = false) MultipartFile[] images,
                          RedirectAttributes redirectAttributes) {
        try {
            bookService.updateBook(isbn, bookDetails, images);
            redirectAttributes.addAttribute("success", "edit");
            return "redirect:/admin/book";
        } catch (Exception e) {
            e.printStackTrace();
            redirectAttributes.addAttribute("error", "edit");
            return "redirect:/admin/book";
        }
    }

    @PostMapping("/delete/{isbn}")
    @ResponseBody
    public ResponseEntity<?> deleteBook(@PathVariable String isbn) {
        try {
            bookService.deleteBook(isbn);
            return ResponseEntity.ok().build();
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body("Error deleting book: " + e.getMessage());
        }
    }

    @PostMapping("/toggle-status/{isbn}")
    @ResponseBody
    public ResponseEntity<?> toggleBookStatus(@PathVariable String isbn) {
        try {
            Book book = bookService.getBookByIsbn(isbn);
            book.setIs_discontinued(!book.getIs_discontinued());
            bookService.saveBook(book, null);
            return ResponseEntity.ok().build();
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body("Error toggling book status: " + e.getMessage());
        }
    }

    @PostMapping("/toggle-discount/{isbn}")
    @ResponseBody
    public ResponseEntity<?> toggleDiscount(@PathVariable String isbn) {
        try {
            Book book = bookService.getBookByIsbn(isbn);
            book.setIs_discount(!book.getIs_discount());
            bookService.saveBook(book, null);
            return ResponseEntity.ok().build();
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body("Error toggling discount: " + e.getMessage());
        }
    }

    @PostMapping("/update-quantity/{isbn}")
    @ResponseBody
    public ResponseEntity<?> updateQuantity(
            @PathVariable String isbn,
            @RequestParam Integer quantity) {
        try {
            Book book = bookService.getBookByIsbn(isbn);
            book.setQuantity(quantity);
            bookService.saveBook(book, null);
            return ResponseEntity.ok().build();
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body("Error updating quantity: " + e.getMessage());
        }
    }

    @PostMapping("/update-discount/{isbn}")
    @ResponseBody
    public ResponseEntity<?> updateDiscount(
            @PathVariable String isbn,
            @RequestParam Double discountPercent) {
        try {
            Book book = bookService.getBookByIsbn(isbn);
            book.setDiscount_percent(discountPercent);
            book.setIs_discount(discountPercent > 0);
            bookService.saveBook(book, null);
            return ResponseEntity.ok().build();
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body("Error updating discount: " + e.getMessage());
        }
    }
}