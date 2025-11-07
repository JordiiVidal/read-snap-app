import 'package:read_snap/features/session/domain/domain.dart';

class GetSessionsByBookUseCase {
  final SessionRepository _repository;

  GetSessionsByBookUseCase(this._repository);

  Future<List<SessionEntity>> call(String bookId) async {
    final sessions = await _repository.getSessionsByBook(bookId);
    sessions.sort((a, b) => b.sessionDate.compareTo(a.sessionDate));
    return sessions;
  }
}
