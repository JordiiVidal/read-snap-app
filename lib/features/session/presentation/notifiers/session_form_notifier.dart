import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:read_snap/core/injection_container.dart';
import 'package:read_snap/features/session/dominio/domain.dart';

class SessionFormNotifier extends StateNotifier<SessionEntity> {
  final SaveSessionUseCase _saveSessionUseCase;

  SessionFormNotifier(this._saveSessionUseCase)
    : super(
        SessionEntity(
          id: '',
          bookId: '',
          pagesRead: 0,
          minutesRead: 0,
          startPage: 0,
          endPage: 0,
          startedAt: DateTime.now(),
          endedAt: DateTime.now(),
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
      );

  void updateBookId(String bookId) => state = state.copyWith(bookId: bookId);
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
    );
    await _saveSessionUseCase.call(state);
  }
}

final sessionFormNotifierProvider =
    StateNotifierProvider.autoDispose<SessionFormNotifier, SessionEntity>((
      ref,
    ) {
      final saveSessionUseCase = ref.watch(saveSessionUseCaseProvider);
      return SessionFormNotifier(saveSessionUseCase);
    });
