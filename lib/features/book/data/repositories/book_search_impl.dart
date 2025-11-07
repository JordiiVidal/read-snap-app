import 'package:read_snap/features/book/data/data.dart';
import 'package:read_snap/features/book/domain/domain.dart';

class BookSearchRepositoryImpl implements BookSearchRepository {
  final GoogleBooksDatasource _datasource;

  BookSearchRepositoryImpl(this._datasource);

  @override
  Future<List<BookEntity>> searchBooks(String query) async {
    try {
      return await _datasource.searchBooks(query);
    } catch (e) {
      rethrow;
    }
  }
}
