import 'package:read_snap/features/book/domain/domain.dart';

abstract class BookSearchRepository {
  Future<List<BookEntity>> searchBooks(String query);
}
