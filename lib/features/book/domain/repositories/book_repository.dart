import 'package:read_snap/features/book/domain/entities/book_entity.dart';

abstract class BookRepository {
  Future<List<BookEntity>> getBooks();

  Future<void> addBook(BookEntity book);

  Future<void> updateBook(BookEntity book);

  Future<void> deleteBook(String id);

  Future<BookEntity> getBookById(String id);
}
