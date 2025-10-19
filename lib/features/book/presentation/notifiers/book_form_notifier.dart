import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:read_snap/core/injection_container.dart';
import 'package:read_snap/features/book/domain/domain.dart';

final bookFormNotifierProvider =
    StateNotifierProvider.autoDispose<BookFormNotifier, BookEntity>((ref) {
      final saveBookUseCase = ref.watch(saveBookUseCaseProvider);
      return BookFormNotifier(saveBookUseCase);
    });

class BookFormNotifier extends StateNotifier<BookEntity> {
  final SaveBookUseCase _saveBookUseCase;

  BookFormNotifier(this._saveBookUseCase)
    : super(
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
      );

  void updateName(String name) => state = state.copyWith(name: name);
  void updateAuthor(String author) => state = state.copyWith(author: author);

  void updateTotalPages(int totalPages) {
    final currentPage = state.currentPage ?? 0;
    final newCurrentPage = currentPage > totalPages ? totalPages : currentPage;

    state = state.copyWith(
      totalPages: totalPages,
      currentPage: newCurrentPage == 0 ? null : newCurrentPage,
    );
  }

  void updateCurrentPage(int currentPage) {
    state = state.copyWith(currentPage: currentPage > 0 ? currentPage : null);
  }

  void updateStatus(BookStatus status) {
    state = state.copyWith(status: status);
  }

  void updateColor(String color) => state = state.copyWith(color: color);

  Future<void> saveBook() async {
    await _saveBookUseCase.call(state);
  }
}
