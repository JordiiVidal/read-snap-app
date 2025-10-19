import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:read_snap/core/injection_container.dart';
import 'package:read_snap/features/book/domain/domain.dart';
import 'package:read_snap/features/book/presentation/presentation.dart';
import 'package:read_snap/features/session/dominio/domain.dart';

final sessionFormNotifierProvider = StateNotifierProvider.family
    .autoDispose<SessionFormNotifier, SessionEntity, String>((ref, bookId) {
      final bookAsync = ref.watch(bookDetailNotifierProvider(bookId));
      final saveSessionUseCase = ref.watch(saveSessionUseCaseProvider);
      return SessionFormNotifier(saveSessionUseCase, bookId, bookAsync);
    });

class SessionFormNotifier extends StateNotifier<SessionEntity> {
  final SaveSessionUseCase _saveSessionUseCase;

  SessionFormNotifier(
    this._saveSessionUseCase,
    String bookId,
    AsyncValue<BookEntity> bookAsync,
  ) : super(
        SessionEntity(
          id: '',
          bookId: bookId,
          pagesRead: 0,
          minutesRead: 0,
          startPage: 0,
          endPage: 0,
          startedAt: DateTime.now(),
          endedAt: DateTime.now(),
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
      ) {
    bookAsync.whenData((book) {
      final currentPage = book.currentPage ?? 0;
      if (state.startPage == 0) {
        state = state.copyWith(startPage: currentPage);
      }
    });
  }

  void updatePagesRead(int pagesRead) =>
      state = state.copyWith(pagesRead: pagesRead);
  void updateMinutesRead(int minutesRead) =>
      state = state.copyWith(minutesRead: minutesRead);
  void updateStartPage(int startPage) =>
      state = state.copyWith(startPage: startPage);
  void updateEndPage(int endPage) => state = state.copyWith(endPage: endPage);
  void updateStartedAt(DateTime startedAt) =>
      state = state.copyWith(startedAt: startedAt);
  void updateEndedAt(DateTime endedAt) =>
      state = state.copyWith(endedAt: endedAt);

  Future<void> saveSession() async {
    state = state.copyWith(
      updatedAt: DateTime.now(),
      pagesRead: state.endPage! - state.startPage!,
      startedAt: DateTime.now(), // TODO
      endedAt: DateTime.now(), // TODO
    );
    await _saveSessionUseCase.call(state);
  }
}
