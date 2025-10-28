import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:read_snap/core/injection_container.dart';
import 'package:read_snap/features/book/domain/domain.dart';

final bookCreateNotifierProvider =
    StateNotifierProvider.autoDispose<
      BookCreateNotifier,
      AsyncValue<BookEntity>
    >((ref) {
      final crateBookUseCase = ref.watch(createBookUseCaseProvider);
      return BookCreateNotifier(crateBookUseCase);
    });

class BookCreateNotifier extends StateNotifier<AsyncValue<BookEntity>> {
  final CreateBookUseCase _createBookUseCase;

  BookCreateNotifier(this._createBookUseCase)
    : super(
        AsyncValue.data(
          BookEntity(
            id: '',
            name: '',
            author: '',
            totalPages: 0,
            currentPage: 0,
            status: BookStatus.toRead,
            color: '#673AB7',
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
          ),
        ),
      );

  BookEntity get currentBookDraft => state.value!;

  void updateName(String name) =>
      state = AsyncValue.data(currentBookDraft.copyWith(name: name));

  void updateAuthor(String author) {
    state = AsyncValue.data(currentBookDraft.copyWith(author: author));
  }

  void updateTotalPages(int totalPages) {
    state = AsyncValue.data(currentBookDraft.copyWith(totalPages: totalPages));
  }

  void updateStatus(BookStatus status) {
    state = AsyncValue.data(currentBookDraft.copyWith(status: status));
  }

  Future<BookEntity> createBook() async {
    final previousState = state;
    state = AsyncValue<BookEntity>.loading().copyWithPrevious(previousState);
    try {
      final createdBook = await _createBookUseCase.call(currentBookDraft);
      state = AsyncValue.data(createdBook);
      return createdBook;
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
