import 'package:read_snap/features/session/dominio/domain.dart';

class GetSessionsUseCase {
  final SessionRepository _repository;

  GetSessionsUseCase(this._repository);

  Future<List<SessionEntity>> call() async {
    final sessions = await _repository.getSessions();
    sessions.sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
    return sessions;
  }
}
