import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:read_snap/core/injection_container.dart';
import 'package:read_snap/features/book/domain/domain.dart';

final bookDetailNotifierProvider = StateNotifierProvider.family
    .autoDispose<BookDetailNotifier, AsyncValue<BookEntity>, String>((
      ref,
      bookId,
    ) {
      final getBookByIdUseCase = ref.watch(getBookByIdUseCaseProvider);
      final deleteBookUseCase = ref.watch(deleteBookUseCaseProvider);
      return BookDetailNotifier(bookId, getBookByIdUseCase, deleteBookUseCase);
    });

class BookDetailNotifier extends StateNotifier<AsyncValue<BookEntity>> {
  final GetBookByIdUseCase _getBookByIdUseCase;
  final DeleteBookUseCase _deleteBookUseCase;
  final String _bookId;

  BookDetailNotifier(
    this._bookId,
    this._getBookByIdUseCase,
    this._deleteBookUseCase,
  ) : super(const AsyncValue.loading()) {
    loadBook();
  }

  Future<void> loadBook() async {
    state = const AsyncValue.loading();
    try {
      final book = await _getBookByIdUseCase.call(_bookId);
      state = AsyncValue.data(book);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> deleteBook() async {
    if (state.hasValue) {
      await _deleteBookUseCase.call(state.value!.id);
    }
  }
}
