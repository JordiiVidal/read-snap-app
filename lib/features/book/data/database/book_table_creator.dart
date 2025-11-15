import 'package:read_snap/features/book/data/data.dart';
import 'package:sqflite/sqflite.dart';

Future<void> createBookTable(Database db) async {
  await db.execute('''
      CREATE TABLE ${BookMapper.table} (
        ${BookMapper.id} TEXT PRIMARY KEY,
        ${BookMapper.title} TEXT NOT NULL, 
        ${BookMapper.author} TEXT NOT NULL, 
        ${BookMapper.categories} TEXT NOT NULL, 
        ${BookMapper.language} TEXT NOT NULL,
        ${BookMapper.totalPages} INTEGER NOT NULL,
        ${BookMapper.currentPage} INTEGER NOT NULL,
        ${BookMapper.status} TEXT NOT NULL,
        ${BookMapper.type} TEXT NOT NULL,
        ${BookMapper.createdAt} INTEGER NOT NULL,
        ${BookMapper.updatedAt} INTEGER NOT NULL,
        ${BookMapper.identifiers} TEXT,
        ${BookMapper.googleExternalId} TEXT, 
        ${BookMapper.imageThumbnail} TEXT,
        ${BookMapper.finishedAt} INTEGER,
        ${BookMapper.startedAt} INTEGER
      )
  ''');

  await db.execute('''
    CREATE UNIQUE INDEX idx_book_title 
    ON ${BookMapper.table}(${BookMapper.title})
  ''');
}
