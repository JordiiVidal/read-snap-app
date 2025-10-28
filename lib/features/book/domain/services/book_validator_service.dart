import 'package:read_snap/features/book/domain/domain.dart';

class BookValidatorService {
  const BookValidatorService();

  void validateCreationFields(BookEntity book) {
    if (book.name.trim().isEmpty || book.author.trim().isEmpty) {
      throw ArgumentError('Book name and author cannot be empty.');
    }
    if (book.totalPages <= 0) {
      throw ArgumentError('Total pages must be a positive number.');
    }
  }

  void validateUpdateFields(BookEntity book) {
    switch (book.status) {
      case BookStatus.toRead:
        if (book.currentPage != 0) {
          throw ArgumentError('For status "To Read", current page must be 0.');
        }
        break;
      case BookStatus.reading:
        if (book.currentPage < 0 || book.currentPage >= book.totalPages) {
          throw ArgumentError(
            'For status "Reading", current page must be between 0 and ${book.totalPages}.',
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
