import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:read_snap/core/injection_container.dart';
import 'package:read_snap/features/session/domain/domain.dart';

final sessionListNotifierProvider = StateNotifierProvider.family
    .autoDispose<SessionListNotifier, AsyncValue<List<SessionEntity>>, String>((
      ref,
      bookId,
    ) {
      final getSessionsByBookUseCase = ref.watch(
        getSessionsByBookUseCaseProvider,
      );
      return SessionListNotifier(getSessionsByBookUseCase, bookId);
    });

class SessionListNotifier
    extends StateNotifier<AsyncValue<List<SessionEntity>>> {
  final GetSessionsByBookUseCase _getSessionsByBookUseCase;
  final String _bookId;

  SessionListNotifier(this._getSessionsByBookUseCase, this._bookId)
    : super(const AsyncValue.loading()) {
    loadSessions();
  }

  Future<void> loadSessions() async {
    state = const AsyncValue.loading();
    try {
      final sessions = await _getSessionsByBookUseCase.call(_bookId);
      state = AsyncValue.data(sessions);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
