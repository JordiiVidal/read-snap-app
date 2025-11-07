import 'package:read_snap/features/session/data/data.dart';
import 'package:read_snap/features/session/domain/domain.dart';
import 'package:sqflite/sqflite.dart';

class SessionRepositoryImpl implements SessionRepository {
  final Database _db;

  SessionRepositoryImpl(this._db);

  @override
  Future<List<SessionEntity>> getSessions() async {
    final List<Map<String, dynamic>> maps = await _db.query(
      SessionMapper.table,
      orderBy: '${SessionMapper.sessionDate} DESC',
    );
    return List.generate(maps.length, (i) => SessionMapper.fromMap(maps[i]));
  }

  @override
  Future<List<SessionEntity>> getSessionsByBook(String bookId) async {
    final List<Map<String, dynamic>> maps = await _db.query(
      SessionMapper.table,
      where: '${SessionMapper.bookId} = ?',
      whereArgs: [bookId],
      orderBy: '${SessionMapper.sessionDate} DESC',
    );
    return List.generate(maps.length, (i) => SessionMapper.fromMap(maps[i]));
  }

  @override
  Future<void> saveSession(SessionEntity session) async {
    await _db.insert(
      SessionMapper.table,
      SessionMapper.toMap(session),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<void> deleteSession(String id) async {
    await _db.delete(
      SessionMapper.table,
      where: '${SessionMapper.id} = ?',
      whereArgs: [id],
    );
  }
}
