import 'package:read_snap/features/book/data/data.dart';
import 'package:read_snap/features/session/data/data.dart';
import 'package:sqflite/sqlite_api.dart';

Future<void> createSessionTable(Database db) async {
  await db.execute('''
      CREATE TABLE ${SessionMapper.table} (
        ${SessionMapper.id} TEXT PRIMARY KEY,
        ${SessionMapper.bookId} TEXT NOT NULL,
        ${SessionMapper.startPage} INTEGER NOT NULL,
        ${SessionMapper.endPage} INTEGER NOT NULL,
        ${SessionMapper.pagesRead} INTEGER NOT NULL,
        ${SessionMapper.minutesRead} INTEGER NOT NULL,
        ${SessionMapper.sessionDate} INTEGER NOT NULL,
        ${SessionMapper.createdAt} INTEGER NOT NULL,
        ${SessionMapper.updatedAt} INTEGER NOT NULL,
        FOREIGN KEY(${SessionMapper.bookId}) 
        REFERENCES ${BookMapper.table}(${BookMapper.id}) 
        ON DELETE CASCADE
      )
  ''');
}
