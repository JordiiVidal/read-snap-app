import 'package:read_snap/features/session/dominio/domain.dart';

class SaveSessionUseCase {
  final SessionRepository _repository;

  SaveSessionUseCase(this._repository);

  Future<void> call(SessionEntity session) async {
    // Business logic
    // Validations
    // Persistence
    if (session.id.isNotEmpty) {
      await _repository.updateSession(session);
    } else {
      await _repository.addSession(session);
    }
  }
}
