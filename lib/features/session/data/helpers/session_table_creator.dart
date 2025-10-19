import 'package:read_snap/features/book/data/data.dart';
import 'package:read_snap/features/session/data/data.dart';
import 'package:sqflite/sqlite_api.dart';

Future<void> createSessionTable(Database db) async {
  await db.execute('''
      CREATE TABLE ${SessionModel.table} (
        ${SessionModel.id} TEXT PRIMARY KEY,
        ${SessionModel.bookId} TEXT NOT NULL,
        ${SessionModel.startPage} INTEGER NOT NULL,
        ${SessionModel.endPage} INTEGER NOT NULL,
        ${SessionModel.pagesRead} INTEGER NOT NULL,
        ${SessionModel.minutesRead} INTEGER NOT NULL,
        ${SessionModel.sessionDate} INTEGER NOT NULL,
        ${SessionModel.createdAt} INTEGER NOT NULL,
        ${SessionModel.updatedAt} INTEGER NOT NULL,
        FOREIGN KEY(${SessionModel.bookId}) 
        REFERENCES ${BookModel.table}(${BookModel.id}) 
        ON DELETE CASCADE
      )
  ''');
}
