import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:read_snap/core/di/injection_container.dart';
import 'package:read_snap/features/book/presentation/notifiers/book_detail_notifier.dart';
import 'package:read_snap/features/book/presentation/notifiers/book_list_notifier.dart';
import 'package:read_snap/features/session/domain/domain.dart';

final sessionCreateNotifierProvider = AsyncNotifierProvider.family
    .autoDispose<SessionCreateNotifier, SessionEntity, String>(
      SessionCreateNotifier.new,
    );

class SessionCreateNotifier
    extends AutoDisposeFamilyAsyncNotifier<SessionEntity, String> {
  late SaveSessionUseCase _saveSessionUseCase;
  late int _bookTotalPages;

  @override
  Future<SessionEntity> build(String bookId) async {
    _saveSessionUseCase = ref.read(saveSessionUseCaseProvider);

    final book = await ref.read(getBookByIdUseCaseProvider).call(bookId);
    _bookTotalPages = book.totalPages;

    return SessionEntity(
      id: '',
      bookId: bookId,
      startPage: book.currentPage,
      endPage: book.currentPage,
      minutesRead: 1,
      pagesRead: 0,
      sessionDate: DateTime.now(),
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }

  SessionEntity get _currentSessionEntity => state.value!;

  int get totalPages => _bookTotalPages;

  void restart() {
    updateStartPage(0);
    updateEndPage(0);
  }

  void markAsFinished() {
    updateEndPage(totalPages);
  }

  void today() {
    updateSessionDate(DateTime.now());
  }

  void yesterday() {
    updateSessionDate(DateTime.now().subtract(const Duration(days: 1)));
  }

  void plusMinuts(int sum) {
    updateMinutesRead(_currentSessionEntity.minutesRead + sum);
  }

  void updateMinutesRead(int minutesRead) {
    state.whenData((session) {
      state = AsyncValue.data(session.copyWith(minutesRead: minutesRead));
    });
  }

  void updateStartPage(int startPage) {
    state.whenData((session) {
      state = AsyncValue.data(session.copyWith(startPage: startPage));
    });
  }

  void updateEndPage(int endPage) {
    state.whenData((session) {
      state = AsyncValue.data(session.copyWith(endPage: endPage));
    });
  }

  void updateSessionDate(DateTime sessionDate) {
    state.whenData((session) {
      final dateOnly = DateTime(
        sessionDate.year,
        sessionDate.month,
        sessionDate.day,
      );
      state = AsyncValue.data(session.copyWith(sessionDate: dateOnly));
    });
  }

  Future<void> saveSession() async {
    final previousState = state;
    state = AsyncValue<SessionEntity>.loading().copyWithPrevious(previousState);

    try {
      await _saveSessionUseCase.call(_currentSessionEntity);
      ref.invalidate(bookListNotifierProvider);
      ref.invalidate(bookDetailNotifierProvider(_currentSessionEntity.bookId));
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
