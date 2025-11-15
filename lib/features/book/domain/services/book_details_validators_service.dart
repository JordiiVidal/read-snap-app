import 'package:read_snap/features/book/domain/domain.dart';

class BookDetailsValidatorService {
  static String? validateBookDetails(BookEntity book) {
    if (book.language.isEmpty) {
      return 'Language is required';
    }

    if (book.categories.isEmpty) {
      return 'At least one category is required';
    }

    return null; // No errors
  }
}
