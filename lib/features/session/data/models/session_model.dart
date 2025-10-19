import 'package:read_snap/features/session/dominio/domain.dart';

class SessionModel {
  static const String table = 'sessions';
  // Columns
  static const String id = 'id';
  static const String bookId = 'book_id';
  static const String startPage = 'start_page';
  static const String endPage = 'end_page';
  static const String pagesRead = 'pages_read';
  static const String minutesRead = 'minutes_read';
  static const String sessionDate = 'session_date';
  static const String createdAt = 'created_at';
  static const String updatedAt = 'updated_at';

  Map<String, dynamic> toMap(SessionEntity entity) {
    return {
      id: entity.id,
      bookId: entity.bookId,
      startPage: entity.startPage,
      endPage: entity.endPage,
      pagesRead: entity.pagesRead,
      minutesRead: entity.minutesRead,
      sessionDate: entity.sessionDate.millisecondsSinceEpoch,
      createdAt: entity.createdAt.millisecondsSinceEpoch,
      updatedAt: entity.updatedAt.millisecondsSinceEpoch,
    };
  }

  SessionEntity fromMap(Map<String, dynamic> map) {
    return SessionEntity(
      id: map[id],
      bookId: map[bookId],
      startPage: map[startPage],
      endPage: map[endPage],
      pagesRead: map[pagesRead],
      minutesRead: map[minutesRead],
      sessionDate: DateTime.fromMillisecondsSinceEpoch(map[sessionDate]),
      createdAt: DateTime.fromMillisecondsSinceEpoch(map[createdAt]),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(map[updatedAt]),
    );
  }
}
