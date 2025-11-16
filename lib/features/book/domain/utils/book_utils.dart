import 'package:read_snap/features/book/domain/domain.dart';

class BookUtils {
  static String getBookTypeName(BookType type) {
    switch (type) {
      case BookType.paper:
        return 'Paperback';
      case BookType.digital:
        return 'eBook';
    }
  }

  static String getBookStatusName(BookStatus status) {
    switch (status) {
      case BookStatus.toRead:
        return 'To Read';
      case BookStatus.reading:
        return 'Reading';
      case BookStatus.completed:
        return 'Completed';
    }
  }

  static String formatPageCount(int pages) {
    return pages == 1 ? '1 page' : '$pages pages';
  }

  static bool hasValidThumbnail(BookEntity book) {
    return book.imageThumbnail != null && book.imageThumbnail!.isNotEmpty;
  }

  BookUtils._();
}
