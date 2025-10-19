import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:read_snap/core/injection_container.dart';
import 'package:read_snap/features/book/domain/domain.dart';

final bookFormNotifierProvider =
    StateNotifierProvider.autoDispose<BookFormNotifier, AsyncValue<BookEntity>>(
      (ref) {
        final saveBookUseCase = ref.watch(saveBookUseCaseProvider);
        return BookFormNotifier(saveBookUseCase);
      },
    );

class BookFormNotifier extends StateNotifier<AsyncValue<BookEntity>> {
  final SaveBookUseCase _saveBookUseCase;

  BookFormNotifier(this._saveBookUseCase)
    : super(
        AsyncValue.data(
          BookEntity(
            id: '',
            name: '',
            author: '',
            totalPages: 0,
            currentPage: 0,
            status: BookStatus.toRead,
            color: '#808080',
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
          ),
        ),
      );

  BookEntity get _currentBookEntity => state.value!;

  void updateName(String name) =>
      state = AsyncValue.data(_currentBookEntity.copyWith(name: name));

  void updateAuthor(String author) {
    state = AsyncValue.data(_currentBookEntity.copyWith(author: author));
  }

  void updateTotalPages(int totalPages) {
    state = AsyncValue.data(
      _currentBookEntity.copyWith(totalPages: totalPages),
    );
  }

  void updateCurrentPage(int currentPage) {
    state = AsyncValue.data(
      _currentBookEntity.copyWith(currentPage: currentPage),
    );
  }

  void updateStatus(BookStatus status) {
    state = AsyncValue.data(_currentBookEntity.copyWith(status: status));
  }

  void updateColor(String color) =>
      state = AsyncValue.data(_currentBookEntity.copyWith(color: color));

  Future<void> saveBook() async {
    final previousState = state;
    state = AsyncValue<BookEntity>.loading().copyWithPrevious(previousState);
    try {
      await _saveBookUseCase.call(_currentBookEntity);
    } on ArgumentError catch (_) {
      // Error to widget
      state = previousState;
      rethrow;
    } catch (e, _) {
      // Error to widget
      state = previousState;
      rethrow;
    }
  }
}
