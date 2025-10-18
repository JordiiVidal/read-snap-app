import 'package:read_snap/features/session/dominio/domain.dart';

class GetSessionsUseCase {
  final SessionRepository _sessionRepository;

  GetSessionsUseCase(this._sessionRepository);

  Future<List<SessionEntity>> call() async {
    final sessions = await _sessionRepository.getSessions();
    sessions.sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
    return sessions;
  }
}
