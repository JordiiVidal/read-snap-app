import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:read_snap/core/di/injection_container.dart';
import 'package:read_snap/features/book/domain/domain.dart';

final bookUpdateNotifierProvider = StateNotifierProvider.autoDispose
    .family<BookUpdateNotifier, AsyncValue<BookEntity>, BookEntity>((
      ref,
      initialBook,
    ) {
      final updateBookUseCase = ref.watch(updateBookUseCaseProvider);
      return BookUpdateNotifier(updateBookUseCase, initialBook);
    });

class BookUpdateNotifier extends StateNotifier<AsyncValue<BookEntity>> {
  final UpdateBookUseCase _updateBookUseCase;

  BookUpdateNotifier(this._updateBookUseCase, BookEntity initialBook)
    : super(AsyncValue.data(initialBook));

  BookEntity get currentBookDraft => state.value!;

  void updateCurrentPage(int currentPage) {
    state = AsyncValue.data(
      currentBookDraft.copyWith(currentPage: currentPage),
    );
  }

  void updateStatus(BookStatus status) {
    state = AsyncValue.data(currentBookDraft.copyWith(status: status));
  }

  void updateStartedAt(DateTime startDate) {
    state = AsyncValue.data(currentBookDraft.copyWith(startedAt: startDate));
  }

  void updateFinishedAt(DateTime endDate) {
    state = AsyncValue.data(currentBookDraft.copyWith(finishedAt: endDate));
  }

  Future<void> updateBook() async {
    final previousState = state;
    state = AsyncValue<BookEntity>.loading().copyWithPrevious(previousState);
    try {
      await _updateBookUseCase.call(currentBookDraft);
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
