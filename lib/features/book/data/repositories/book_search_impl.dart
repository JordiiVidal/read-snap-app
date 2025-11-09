import 'package:read_snap/features/book/data/data.dart';
import 'package:read_snap/features/book/domain/domain.dart';
import 'package:read_snap/features/category/domain/domain.dart';

class BookSearchRepositoryImpl implements BookSearchRepository {
  final GoogleBooksDatasource _datasource;
  final FindCategoriesByAliasUseCase _findCategoriesUseCase;

  BookSearchRepositoryImpl(this._datasource, this._findCategoriesUseCase);

  @override
  Future<List<BookEntity>> searchBooks(String query) async {
    try {
      final jsonList = await _datasource.searchBooks(query);

      final books = <BookEntity>[];
      for (final json in jsonList) {
        final book = await GoogleBooksMapper.fromGoogleBooksJson(
          json,
          _findCategoriesUseCase,
        );
        books.add(book);
      }

      return books;
    } catch (e) {
      rethrow;
    }
  }
}
