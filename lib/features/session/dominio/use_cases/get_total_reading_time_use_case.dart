import 'package:read_snap/features/session/dominio/domain.dart';

class GetTotalReadingTimeUseCase {
  final SessionRepository _sessionRepository;

  GetTotalReadingTimeUseCase(this._sessionRepository);

  Future<int> call(String bookId) async {
    final sessions = await _sessionRepository.getSessionsByBook(bookId);
    return sessions.fold<int>(0, (sum, session) => sum + session.minutesRead);
  }
}
