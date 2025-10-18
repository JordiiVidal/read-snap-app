import 'package:read_snap/features/session/dominio/domain.dart';

class SaveSessionUseCase {
  final SessionRepository _sessionRepository;

  SaveSessionUseCase(this._sessionRepository);

  Future<void> call(SessionEntity session) async {
    // Business logic
    // Validations
    // Persistence
    if (session.id.isNotEmpty) {
      await _sessionRepository.updateSession(session);
    } else {
      await _sessionRepository.addSession(session);
    }
  }
}
