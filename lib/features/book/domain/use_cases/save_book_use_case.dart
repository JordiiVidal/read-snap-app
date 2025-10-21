import 'package:read_snap/features/book/domain/entities/book_entity.dart';
import 'package:read_snap/features/book/domain/repositories/book_repository.dart';
import 'package:uuid/uuid.dart';

class SaveBookUseCase {
  final BookRepository _repository;

  SaveBookUseCase(this._repository);

  Future<void> call(BookEntity book) async {
    // 1.Business logic
    BookEntity bookToSave = _applyBusinessLogic(book);

    // 2.Validations
    _validateBook(bookToSave);
    final existingBook = await _repository.getBookByName(book.name);
    if (existingBook != null && existingBook.id != book.id) {
      throw ArgumentError(
        'A book with the name "${book.name}" already exists.',
      );
    }

    // 3.Persistence
    if (bookToSave.id.isNotEmpty) {
      // Update
      bookToSave = bookToSave.copyWith(updatedAt: DateTime.now());
      await _repository.updateBook(bookToSave);
    } else {
      // Create
      final now = DateTime.now();
      bookToSave = bookToSave.copyWith(
        id: const Uuid().v4(),
        createdAt: now,
        updatedAt: now,
      );
      await _repository.addBook(bookToSave);
    }
  }

  BookEntity _applyBusinessLogic(BookEntity book) {
    switch (book.status) {
      case BookStatus.toRead:
        return book.copyWith(currentPage: 0);
      case BookStatus.completed:
        return book.copyWith(currentPage: book.totalPages);
      case BookStatus.reading:
        return book;
    }
  }

  void _validateBook(BookEntity book) {
    if (book.name.trim().isEmpty || book.author.trim().isEmpty) {
      throw ArgumentError('Book name and author cannot be empty.');
    }
    if (book.totalPages <= 0) {
      throw ArgumentError('Total pages must be a positive number.');
    }
    switch (book.status) {
      case BookStatus.toRead:
        if (book.currentPage != 0) {
          throw ArgumentError('For status "To Read", current page must be 0.');
        }
        break;
      case BookStatus.reading:
        if (book.currentPage <= 0 || book.currentPage >= book.totalPages) {
          throw ArgumentError(
            'For status "Reading", current page must be between 1 and ${book.totalPages - 1}.',
          );
        }
        break;
      case BookStatus.completed:
        if (book.currentPage != book.totalPages) {
          throw ArgumentError(
            'For status "Completed", current page must equal total pages.',
          );
        }
        break;
    }
  }
}
