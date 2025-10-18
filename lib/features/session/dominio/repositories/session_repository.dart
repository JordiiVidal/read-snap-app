import 'package:read_snap/features/session/dominio/domain.dart';

abstract class SessionRepository {
  Future<List<SessionEntity>> getSessions();

  Future<void> addSession(SessionEntity session);

  Future<void> updateSession(SessionEntity session);

  Future<void> deleteSession(String id);
}
