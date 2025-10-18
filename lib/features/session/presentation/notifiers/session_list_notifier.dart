import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:read_snap/core/injection_container.dart';
import 'package:read_snap/features/session/dominio/domain.dart';

class SessionListNotifier extends AsyncNotifier<List<SessionEntity>> {
  @override
  Future<List<SessionEntity>> build() async {
    return _fetchSessions();
  }

  Future<List<SessionEntity>> _fetchSessions() async {
    final getSessions = ref.read(getSessionsUseCaseProvider);
    return await getSessions.call();
  }

  Future<void> refreshSessions() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(_fetchSessions);
  }

  Future<void> sessionOperationCompleted() async {
    await refreshSessions();
  }
}

final sessionListNotifierProvider =
    AsyncNotifierProvider<SessionListNotifier, List<SessionEntity>>(
      () => SessionListNotifier(),
    );
