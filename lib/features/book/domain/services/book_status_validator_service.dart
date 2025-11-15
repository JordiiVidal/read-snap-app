import 'package:read_snap/features/book/domain/domain.dart';

class BookStatusValidatorService {
  static String? validateBookStatus(BookEntity book) {
    if (book.totalPages == 0) {
      return 'Total pages must be greater than 0';
    }

    if (book.status == BookStatus.reading) {
      if (book.currentPage > book.totalPages) {
        return 'Current page cannot exceed total pages';
      }
    }

    if (book.status == BookStatus.completed) {
      if (book.startedAt == null) {
        return 'Start date is required for completed books';
      }
      if (book.finishedAt == null) {
        return 'End date is required for completed books';
      }
      if (book.finishedAt!.isBefore(book.startedAt!)) {
        return 'End date must be after start date';
      }
    }

    return null;
  }
}
