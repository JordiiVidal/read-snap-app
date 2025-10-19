import 'package:read_snap/features/session/data/models/session_model.dart';
import 'package:read_snap/features/session/dominio/domain.dart';
import 'package:sqflite/sqflite.dart';

class SessionRepositoryImpl implements SessionRepository {
  final Database _db;
  final SessionModel _model = SessionModel();

  SessionRepositoryImpl(this._db);

  @override
  Future<List<SessionEntity>> getSessions() async {
    final List<Map<String, dynamic>> maps = await _db.query(
      SessionModel.table,
      orderBy: '${SessionModel.sessionDate} DESC',
    );
    return List.generate(maps.length, (i) => _model.fromMap(maps[i]));
  }

  @override
  Future<List<SessionEntity>> getSessionsByBook(String bookId) async {
    final List<Map<String, dynamic>> maps = await _db.query(
      SessionModel.table,
      where: '${SessionModel.bookId} = ?',
      whereArgs: [bookId],
      orderBy: '${SessionModel.sessionDate} DESC',
    );
    return List.generate(maps.length, (i) => _model.fromMap(maps[i]));
  }

  @override
  Future<void> saveSession(SessionEntity session) async {
    await _db.insert(
      SessionModel.table,
      _model.toMap(session),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<void> deleteSession(String id) async {
    await _db.delete(
      SessionModel.table,
      where: '${SessionModel.id} = ?',
      whereArgs: [id],
    );
  }
}
