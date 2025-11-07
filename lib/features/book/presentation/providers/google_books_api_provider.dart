import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:read_snap/features/book/data/repositories/book_search_impl.dart';

final googleBooksApiProvider = Provider<BookSearchRepositoryImpl>((ref) {
  return BookSearchRepositoryImpl();
});
