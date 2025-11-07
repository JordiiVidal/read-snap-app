import 'package:read_snap/features/book/domain/domain.dart';

abstract class BookRepository {
  Future<List<BookEntity>> getBooks();

  Future<BookEntity> getBookById(String id);

  Future<BookEntity?> getBookByNameAndAuthor(String name, String author);

  Future<int> countBooksByStatus(BookStatus status);

  Future<void> addBook(BookEntity book);

  Future<void> updateBook(BookEntity book);

  Future<void> deleteBook(String id);
}
