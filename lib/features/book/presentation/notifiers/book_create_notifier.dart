import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:read_snap/core/di/injection_container.dart';
import 'package:read_snap/features/book/domain/domain.dart';

final defaultBookEntity = BookEntity(
  id: '',
  title: '',
  author: '',
  totalPages: 0,
  currentPage: 0,
  status: BookStatus.toRead,
  type: BookType.paper,
  categories: [],
  language: 'en',
  createdAt: DateTime.now(),
  updatedAt: DateTime.now(),
);

final bookCreateNotifierProvider =
    StateNotifierProvider<BookCreateNotifier, AsyncValue<BookEntity>>((ref) {
      final createBookUseCase = ref.watch(createBookUseCaseProvider);
      return BookCreateNotifier(createBookUseCase);
    });

class BookCreateNotifier extends StateNotifier<AsyncValue<BookEntity>> {
  final CreateBookUseCase _createBookUseCase;

  BookCreateNotifier(this._createBookUseCase)
    : super(AsyncValue.data(defaultBookEntity));

  BookEntity get currentBookDraft => state.value!;

  void updateFromSearch(BookEntity book) {
    final updatedBook = book.copyWith(status: currentBookDraft.status);
    state = AsyncValue.data(updatedBook);
  }

  void updateTitle(String title) =>
      state = AsyncValue.data(currentBookDraft.copyWith(title: title));

  void updateAuthor(String author) {
    state = AsyncValue.data(currentBookDraft.copyWith(author: author));
  }

  void updateTotalPages(int totalPages) {
    state = AsyncValue.data(currentBookDraft.copyWith(totalPages: totalPages));
  }

  void updateStatus(BookStatus status) {
    state = AsyncValue.data(currentBookDraft.copyWith(status: status));
  }

  void updateLanguage(String language) {
    state = AsyncValue.data(currentBookDraft.copyWith(language: language));
  }

  void updateCategories(List<String> categories) {
    state = AsyncValue.data(currentBookDraft.copyWith(categories: categories));
  }

  void updateCurrentPage(int currentPage) {
    state = AsyncValue.data(
      currentBookDraft.copyWith(currentPage: currentPage),
    );
  }

  void updateStartedAt(DateTime startDate) {
    state = AsyncValue.data(currentBookDraft.copyWith(startedAt: startDate));
  }

  void updateFinishedAt(DateTime endDate) {
    state = AsyncValue.data(currentBookDraft.copyWith(finishedAt: endDate));
  }

  void reset() {
    state = AsyncValue.data(defaultBookEntity);
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
