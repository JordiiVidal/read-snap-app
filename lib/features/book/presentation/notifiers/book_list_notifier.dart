import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:read_snap/core/di/injection_container.dart';
import 'package:read_snap/features/book/domain/domain.dart';

final bookListNotifierProvider =
    AsyncNotifierProvider<BookListNotifier, List<BookEntity>>(
      BookListNotifier.new,
    );

class BookListNotifier extends AsyncNotifier<List<BookEntity>> {
  @override
  Future<List<BookEntity>> build() async {
    return _fetchBooks();
  }

  Future<List<BookEntity>> _fetchBooks() async {
    final getBooks = ref.read(getBooksUseCaseProvider);
    return await getBooks.call();
  }

  Future<void> refreshBooks() async {
    ref.invalidateSelf();
    await future;
  }
}
