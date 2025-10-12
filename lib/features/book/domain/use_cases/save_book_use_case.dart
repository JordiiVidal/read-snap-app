import 'package:read_snap/features/book/domain/entities/book_entity.dart';
import 'package:read_snap/features/book/domain/repositories/book_repository.dart';

class SaveBookUseCase {
  final BookRepository _bookRepository;

  SaveBookUseCase(this._bookRepository);

  Future<void> call(BookEntity book) async {
    // Business logic
    BookEntity bookToSave = book;
    if (book.status == BookStatus.completed) {
      bookToSave = book.copyWith(currentPage: book.totalPages);
    }
    // Validations
    if (bookToSave.totalPages < 1) {
      throw ArgumentError('The number of pages must be greater than 0.');
    }
    if (bookToSave.currentPage != null &&
        bookToSave.currentPage! > bookToSave.totalPages) {
      throw ArgumentError(
        'Current page (${bookToSave.currentPage}) cannot exceed total pages (${bookToSave.totalPages}).',
      );
    }
    // Persistence
    if (bookToSave.id.isNotEmpty) {
      await _bookRepository.updateBook(bookToSave);
    } else {
      await _bookRepository.addBook(bookToSave);
    }
  }
}
