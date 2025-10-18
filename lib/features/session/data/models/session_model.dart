import 'package:read_snap/features/session/dominio/domain.dart';

const String tableSessions = 'sessions';

class SessionModel {
  // Columns
  static const String id = 'id';
  static const String bookId = 'book_id';
  static const String pagesRead = 'pages_read';
  static const String minutesRead = 'minutes_read';
  static const String startedAt = 'started_at';
  static const String endedAt = 'ended_at';
  static const String createdAt = 'created_at';
  static const String updatedAt = 'updated_at';

  Map<String, dynamic> toMap(SessionEntity entity) {
    return {
      id: entity.id,
      bookId: entity.bookId,
      pagesRead: entity.pagesRead,
      minutesRead: entity.minutesRead,
      startedAt: entity.startedAt.millisecondsSinceEpoch,
      endedAt: entity.endedAt?.millisecondsSinceEpoch,
      createdAt: entity.createdAt.millisecondsSinceEpoch,
      updatedAt: entity.updatedAt.millisecondsSinceEpoch,
    };
  }

  SessionEntity fromMap(Map<String, dynamic> map) {
    return SessionEntity(
      id: map[id],
      bookId: map[bookId],
      pagesRead: map[pagesRead],
      minutesRead: map[minutesRead],
      startedAt: DateTime.fromMillisecondsSinceEpoch(map[startedAt]),
      endedAt: map[endedAt] != null
          ? DateTime.fromMillisecondsSinceEpoch(map[endedAt]!)
          : null,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map[createdAt]),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(map[updatedAt]),
    );
  }
}
