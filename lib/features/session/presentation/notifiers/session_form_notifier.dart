import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:read_snap/core/injection_container.dart';
import 'package:read_snap/features/book/domain/domain.dart';
import 'package:read_snap/features/book/presentation/presentation.dart';
import 'package:read_snap/features/session/dominio/domain.dart';

final sessionFormNotifierProvider = StateNotifierProvider.family
    .autoDispose<SessionFormNotifier, AsyncValue<SessionEntity>, String>((
      ref,
      bookId,
    ) {
      final bookAsync = ref.watch(bookDetailNotifierProvider(bookId));
      final saveSessionUseCase = ref.watch(saveSessionUseCaseProvider);
      return SessionFormNotifier(saveSessionUseCase, bookId, bookAsync);
    });

class SessionFormNotifier extends StateNotifier<AsyncValue<SessionEntity>> {
  final SaveSessionUseCase _saveSessionUseCase;
  int _bookTotalPages = 0;

  SessionFormNotifier(
    this._saveSessionUseCase,
    String bookId,
    AsyncValue<BookEntity> bookAsync,
  ) : super(const AsyncValue.loading()) {
    _initializeForm(bookId, bookAsync);
  }

  SessionEntity get _currentSessionEntity => state.value!;

  void _initializeForm(String bookId, AsyncValue<BookEntity> bookAsync) {
    final baseSession = SessionEntity(
      id: '',
      bookId: bookId,
      startPage: 0,
      endPage: 0,
      minutesRead: 1,
      pagesRead: 0,
      sessionDate: DateTime.now(),
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    bookAsync.when(
      loading: () {},
      error: (e, st) {
        state = AsyncValue.error(e, st);
      },
      data: (book) {
        final initialStartPage = book.currentPage;
        final initialEndPage = initialStartPage;
        _bookTotalPages = book.totalPages;

        state = AsyncValue.data(
          baseSession.copyWith(
            startPage: initialStartPage,
            endPage: initialEndPage,
          ),
        );
      },
    );
  }

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
