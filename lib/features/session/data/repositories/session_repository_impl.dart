import 'package:read_snap/features/session/data/models/session_model.dart';
import 'package:read_snap/features/session/dominio/domain.dart';
import 'package:sqflite/sqflite.dart';
import 'package:uuid/uuid.dart';

class SessionRepositoryImpl implements SessionRepository {
  final Database _db;
  final SessionModel _sessionModel = SessionModel();

  SessionRepositoryImpl(this._db);

  @override
  Future<List<SessionEntity>> getSessions() async {
    final List<Map<String, dynamic>> maps = await _db.query(tableSessions);
    return List.generate(maps.length, (i) => _sessionModel.fromMap(maps[i]));
  }

  @override
  Future<void> addSession(SessionEntity session) async {
    final sessionToCreate = session.copyWith(
      id: const Uuid().v4(),
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
    await _db.insert(
      tableSessions,
      _sessionModel.toMap(sessionToCreate),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<void> updateSession(SessionEntity session) async {
    final sessionToUpdate = session.copyWith(updatedAt: DateTime.now());
    await _db.update(
      tableSessions,
      _sessionModel.toMap(sessionToUpdate),
      where: '${SessionModel.id} = ?',
      whereArgs: [sessionToUpdate.id],
    );
  }

  @override
  Future<void> deleteSession(String id) async {
    await _db.delete(tableSessions, where: '${SessionModel.id} = ?', whereArgs: [id]);
  }
}
