package com.nnthienphuc.intelligentbookstoreecommercewebsite.service;

import java.nio.file.Paths;
import java.util.List;

import com.nnthienphuc.intelligentbookstoreecommercewebsite.entity.Book;
import com.nnthienphuc.intelligentbookstoreecommercewebsite.DTO.BookDTO;
import com.nnthienphuc.intelligentbookstoreecommercewebsite.entity.Author;
import com.nnthienphuc.intelligentbookstoreecommercewebsite.entity.Category;
import com.nnthienphuc.intelligentbookstoreecommercewebsite.entity.Publisher;
import com.nnthienphuc.intelligentbookstoreecommercewebsite.repository.BookRepository;
import com.nnthienphuc.intelligentbookstoreecommercewebsite.repository.AuthorRepository;
import com.nnthienphuc.intelligentbookstoreecommercewebsite.repository.CategoryRepository;
import com.nnthienphuc.intelligentbookstoreecommercewebsite.repository.PublisherRepository;



import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;
import org.springframework.web.multipart.MultipartFile;

import java.math.BigDecimal;
import java.util.List;


@Service
@Transactional
public class BookService {

    @Autowired
    private BookRepository bookRepository;

    @Autowired
    private CategoryRepository categoryRepository;

    @Autowired
    private AuthorRepository authorRepository;

    @Autowired
    private PublisherRepository publisherRepository;

    public Page<Book> getAllBooks(Pageable pageable) {
        return bookRepository.findAll(pageable);
    }

    public List<Book> getAllBooks() {
        return bookRepository.findAll();
    }

    public Page<Book> searchBooks(String keyword, Long categoryId, Long authorId, Pageable pageable) {
        try {
            if (keyword != null && !keyword.trim().isEmpty()) {
                keyword = keyword.trim();
            } else {
                keyword = null;
            }

            Category category = null;
            if (categoryId != null) {
                category = categoryRepository.findById(categoryId)
                    .orElseThrow(() -> new RuntimeException("Category not found"));
            }

            Author author = null;
            if (authorId != null) {
                author = authorRepository.findById(authorId)
                    .orElseThrow(() -> new RuntimeException("Author not found"));
            }

            // Tìm kiếm với các điều kiện khác nhau
            if (keyword == null && category == null && author == null) {
                return bookRepository.findAll(pageable);
            } else if (keyword != null && category == null && author == null) {
                return bookRepository.findByTitleContainingIgnoreCase(keyword, pageable);
            } else if (keyword == null && category != null && author == null) {
                return bookRepository.findByCategoryId(category, pageable);
            } else if (keyword == null && category == null && author != null) {
                return bookRepository.findByAuthorId(author, pageable);
            } else if (keyword != null && category != null && author == null) {
                return bookRepository.findByTitleContainingIgnoreCaseAndCategoryId(keyword, category, pageable);
            } else if (keyword != null && category == null && author != null) {
                return bookRepository.findByTitleContainingIgnoreCaseAndAuthorId(keyword, author, pageable);
            } else if (keyword == null && category != null && author != null) {
                return bookRepository.findByCategoryIdAndAuthorId(category, author, pageable);
            } else {
                return bookRepository.findByTitleContainingIgnoreCaseAndCategoryIdAndAuthorId(
                    keyword, category, author, pageable);
            }
        } catch (Exception e) {
            throw new RuntimeException("Error searching books", e);
        }
    }

    public Book getBookByIsbn(String isbn) {
        return bookRepository.findById(isbn)
            .orElseThrow(() -> new RuntimeException("Book not found"));
    }
    public BookDTO getBookDTOByIsbn(String isbn) {
        Book b = bookRepository.findById(isbn)
            .orElseThrow(() -> new RuntimeException("Book not found"));
        BookDTO result = convertToDTO(b);
        return result;
    }
    public BookDTO convertToDTO(Book book) {
        BookDTO bookDTO = new BookDTO();
        bookDTO.setIsbn(book.getIsbn());
        bookDTO.setTitle(book.getTitle());
        bookDTO.setCategoryId(book.getCategoryId().getCategoryId()); // Giả sử bạn có phương thức getId() trong Category
        bookDTO.setAuthorId(book.getAuthorId().getAuthorId()); // Giả sử bạn có phương thức getId() trong Author
        bookDTO.setYear_of_publication(book.getYear_of_publication());
        bookDTO.setPublisherId(book.getPublisherId().getPublisherId()); // Giả sử bạn có phương thức getId() trong Publisher
        bookDTO.setQuantity(book.getQuantity());
        bookDTO.setCover(book.getCover());
        bookDTO.setPrice(book.getPrice());
        bookDTO.setDiscount_percent(book.getDiscount_percent());
        bookDTO.setIs_discount(book.getIs_discount());
        bookDTO.setDescription(book.getDescription());
        bookDTO.setUrl1(book.getUrl1());
        bookDTO.setUrl2(book.getUrl2());
        bookDTO.setUrl3(book.getUrl3());
        bookDTO.setUrl4(book.getUrl4());
        bookDTO.setUrl5(book.getUrl5());
        bookDTO.setIs_discontinued(book.getIs_discontinued());
        bookDTO.setOrderDetails(book.getOrderDetails()); // Nếu bạn muốn giữ nguyên Set<OrderDetail>
        bookDTO.setCarts(book.getCarts()); // Nếu bạn muốn giữ nguyên Set<Cart>

        return bookDTO;
    }
    public Book convertToEntity(BookDTO bookDTO) {
        Book book = new Book();
        book.setIsbn(bookDTO.getIsbn());
        book.setTitle(bookDTO.getTitle());
        
        // Giả sử bạn có các phương thức tìm kiếm Category, Author, và Publisher theo ID
        Category category = categoryRepository.findById(bookDTO.getCategoryId())
            .orElseThrow(() -> new RuntimeException("Category not found"));
        book.setCategoryId(category);
        
        Author author = authorRepository.findByAuthorId((long)bookDTO.getAuthorId())
            .orElseThrow(() -> new RuntimeException("Author not found"));
        book.setAuthorId(author);
        
        book.setYear_of_publication(bookDTO.getYear_of_publication());
        
        Publisher publisher = publisherRepository.findById((long)bookDTO.getPublisherId())
            .orElseThrow(() -> new RuntimeException("Publisher not found"));
        book.setPublisherId(publisher);
        
        book.setQuantity(bookDTO.getQuantity());
        book.setCover(bookDTO.getCover());
        book.setPrice(bookDTO.getPrice());
        book.setDiscount_percent(bookDTO.getDiscount_percent());
        book.setIs_discount(bookDTO.getIs_discount());
        book.setDescription(bookDTO.getDescription());
        book.setUrl1(bookDTO.getUrl1());
        book.setUrl2(bookDTO.getUrl2());
        book.setUrl3(bookDTO.getUrl3());
        book.setUrl4(bookDTO.getUrl4());
        book.setUrl5(bookDTO.getUrl5());
        book.setIs_discontinued(bookDTO.getIs_discontinued());
        
        // Nếu bạn muốn giữ nguyên Set<OrderDetail> và Set<Cart>, bạn có thể thêm logic để chuyển đổi chúng
        // book.setOrderDetails(bookDTO.getOrderDetails());
        // book.setCarts(bookDTO.getCarts());

        return book;
    }
    public Book getBookById(String id) {
        return bookRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Không tìm thấy sách với id: " + id));
    }
    public List<Book> getBookByAuthorID(Integer id) {
        return bookRepository.getBooksByAuthorID(id);


    }
    public List<Book> getBookByCategoryID(Integer id) {
        return bookRepository.getBooksByCategoryID(id);


    }
    public List<Book> getBookByPublisher(Integer id) {
        return bookRepository.getBooksByAuthorID(id);


    }
    public Book saveBook(Book book, MultipartFile[] images) {
        try {
            // Xử lý upload ảnh
            if (images != null && images.length > 0) {
                String uploadDir = "src/main/resources/static/bookImage";

                // Tạo thư mục nếu chưa tồn tại
                Path uploadPath = Paths.get(uploadDir);
                if (!Files.exists(uploadPath)) {
                    Files.createDirectories(uploadPath);
                }

                // Lưu các file ảnh
                for (int i = 0; i < Math.min(images.length, 5); i++) {
                    MultipartFile image = images[i];
                    if (!image.isEmpty()) {
                        String fileName = StringUtils.cleanPath(image.getOriginalFilename());
                        String uniqueFileName = book.getIsbn() + "_" + (i + 1) + "_" + fileName;
                        Path filePath = uploadPath.resolve(uniqueFileName);
                        Files.copy(image.getInputStream(), filePath, StandardCopyOption.REPLACE_EXISTING);

                        // Set URL cho book
                        switch (i) {
                            case 0: book.setUrl1(uniqueFileName); break;
                            case 1: book.setUrl2(uniqueFileName); break;
                            case 2: book.setUrl3(uniqueFileName); break;
                            case 3: book.setUrl4(uniqueFileName); break;
                            case 4: book.setUrl5(uniqueFileName); break;
                        }
                    }
                }
            }

            if(book.getDiscount_percent() == 0)
            	book.setIs_discount(false);
            if(book.getIs_discount() == null)
            	book.setIs_discount(false);
            if(book.getDiscount_percent() >= 1)
            	book.setDiscount_percent(book.getDiscount_percent()/100);
            return bookRepository.save(book);
        } catch (Exception e) {
            throw new RuntimeException("Could not save book", e);
        }
    }

    public Book updateBook(String isbn, Book bookDetails, MultipartFile[] images) {
        Book book = getBookByIsbn(isbn);

        // Cập nhật thông tin
        book.setTitle(bookDetails.getTitle());
        book.setCategoryId(bookDetails.getCategoryId());
        book.setAuthorId(bookDetails.getAuthorId());
        book.setYear_of_publication(bookDetails.getYear_of_publication());
        book.setPublisherId(bookDetails.getPublisherId());
        book.setQuantity(bookDetails.getQuantity());
        book.setCover(bookDetails.getCover());
        book.setPrice(bookDetails.getPrice());
        book.setDiscount_percent(bookDetails.getDiscount_percent());
        book.setIs_discount(bookDetails.getIs_discount());
        book.setDescription(bookDetails.getDescription());
        book.setIs_discontinued(bookDetails.getIs_discontinued());

        // Lưu ảnh mới nếu có
        return saveBook(book, images);
    }
    public Book toggleBookStatus(String isbn) {
        Book book = getBookByIsbn(isbn);

        // Cập nhật thông tin
        
        book.setIs_discontinued(!book.getIs_discontinued());

        // Lưu ảnh mới nếu có
        return saveBook(book,null);
    }
    public void deleteBook(String isbn) {
        try {
            Book book = getBookByIsbn(isbn);

            // Xóa ảnh cũ
            String uploadDir = "src/main/resources/static/bookImage";
            deleteBookImage(uploadDir + book.getUrl1());
            deleteBookImage(uploadDir + book.getUrl2());
            deleteBookImage(uploadDir + book.getUrl3());
            deleteBookImage(uploadDir + book.getUrl4());
            deleteBookImage(uploadDir + book.getUrl5());

            bookRepository.deleteById(isbn);
        } catch (Exception e) {
            throw new RuntimeException("Could not delete book", e);
        }
    }

    private void deleteBookImage(String imagePath) {
        try {
            Path path = Paths.get(imagePath);
            if (Files.exists(path)) {
                Files.delete(path);
            }
        } catch (IOException e) {
            // Log error but don't throw exception
            e.printStackTrace();
        }
    }
}