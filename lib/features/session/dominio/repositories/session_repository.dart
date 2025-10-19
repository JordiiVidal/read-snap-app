import 'package:read_snap/features/session/dominio/domain.dart';

abstract class SessionRepository {
  Future<List<SessionEntity>> getSessions();

  Future<List<SessionEntity>> getSessionsByBook(String bookId);

  Future<void> saveSession(SessionEntity session);

  Future<void> deleteSession(String id);
}
